module tb_random_fairness;
parameter int N = 4;
parameter int WEIGHT_W = 3; 

logic clk, rst;
logic [N-1:0] req;
logic [WEIGHT_W-1:0] weights [N-1:0];
logic [N-1:0] grant_out;

    // Trackers for Ratio and Starvation Math
int grant_counts[N];
int wait_times[N];
int total_grants;
int total_weight;
int i; 

weighted_rr_arbiter #(.N(N), .WEIGHT_W(WEIGHT_W)) dut (
    .clk(clk),
    .rst(rst),
    .req(req),
    .weights(weights),
    .grant_out(grant_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk; 
end

    // --- Background Starvation Monitor ---
always @(posedge clk) begin
    if (!rst) begin
        for (i = 0; i < N; i++) begin
            if (req[i] && !grant_out[i]) begin
                wait_times[i]++;
                    
                if (wait_times[i] > ((total_weight - weights[i]) + 5)) begin
                    $display("FAIL: Starvation bound exceeded for Requester %0d! Waited %0d cycles.", i, wait_times[i]);
                end
            end 
            else if (grant_out[i] || !req[i]) begin
                wait_times[i] = 0; 
            end
        end
    end
end

    // --- Background Grant Counter ---
always @(posedge clk) begin
    if (!rst && grant_out != 0) begin
         total_grants++;
        for (i = 0; i < N; i++) begin
            if (grant_out[i]) grant_counts[i]++;
        end
    end
end

    // --- Task: Reset Trackers ---
task automatic reset_trackers(input int w0, input int w1, input int w2, input int w3);
    rst = 1;
    @(posedge clk);
    rst = 0;
        
    total_grants = 0;
    for (int j = 0; j < N; j++) begin
        grant_counts[j] = 0;
        wait_times[j] = 0;
    end
    weights[0] = w0; weights[1] = w1; weights[2] = w2; weights[3] = w3;
    total_weight = w0 + w1 + w2 + w3;
    req = 4'b1111; // Default to all active
endtask

    // --- Task: Evaluate Ratio Check (The Tolerance Math) ---
task automatic check_ratios();
    $display("   Total Grants: %0d", total_grants);
    for (int j = 0; j < N; j++) begin
        real expected_pct = (real'(weights[j]) / real'(total_weight)) * 100.0;
        real actual_pct = (real'(grant_counts[j]) / real'(total_grants)) * 100.0;
            
            // Allow 10% relative tolerance either way
        real margin = expected_pct * 0.10; 
        real lower_bound = expected_pct - margin;
        real upper_bound = expected_pct + margin;

        if (actual_pct >= lower_bound && actual_pct <= upper_bound)
            $display("   PASS: Req %0d -> Target: %.1f%%, Actual: %.1f%%", j, expected_pct, actual_pct);
        else
            $display("   FAIL: Req %0d -> Target: %.1f%%, Actual: %.1f%% (Out of bounds)", j, expected_pct, actual_pct);
    end
endtask

    // --- Test Sequences ---
initial begin
    $display("----------------------------------------");
    $display("   STARTING RANDOM & FAIRNESS TESTS");
    $display("----------------------------------------");

    rst = 1; req = 0;
    @(posedge clk); @(posedge clk);
    rst = 0;

        // Test 1: Equal weights
    $display("\n[TEST] All active, equal weights (200 cycles)");
    reset_trackers(2, 2, 2, 2);
    repeat(200) @(posedge clk);
    check_ratios();

        // Test 2: Unequal weights
    $display("\n[TEST] All active, unequal weights (200 cycles)");
    reset_trackers(1, 2, 3, 4); // Total weight = 10
    repeat(200) @(posedge clk);
    check_ratios();

        // Test 3: Min / Max weights
    $display("\n[TEST] All active at minimum weight (1)");
    reset_trackers(1, 1, 1, 1);
    repeat(100) @(posedge clk);
    check_ratios();

    $display("\n[TEST] All active at maximum weight (4)");
    reset_trackers(4, 4, 4, 4);
    repeat(100) @(posedge clk);
    check_ratios();

        // Test 4: Long run (500+ cycles)
    $display("\n[TEST] Long Run (500 cycles) for Zero Starvation Violations");
    reset_trackers(1, 3, 2, 4);
    repeat(500) @(posedge clk);
    check_ratios();
    $display("   PASS: Completed 500 cycles. See Starvation Monitor above for any fails.");

        // Test 5: Randomized run
    $display("\n[TEST] Randomized constraints run (300 cycles)");
    reset_trackers(2, 2, 2, 2); // Initial weights
    for (int k = 0; k < 300; k++) begin
        req <= $urandom_range(1, 15); // Randomly toggle requests (ensure at least 1 active)
        if (k % 50 == 0) begin
                // Randomize weights every 50 cycles
            weights[0] <= $urandom_range(1, 4);
            weights[1] <= $urandom_range(1, 4);
            weights[2] <= $urandom_range(1, 4);
            weights[3] <= $urandom_range(1, 4);
        end
        @(posedge clk);
    end
    $display("   PASS: Randomized run complete.");

    $display("\n----------------------------------------");
    $display("   FAIRNESS TESTS COMPLETE");
    $display("----------------------------------------");
    $finish;
end
endmodule