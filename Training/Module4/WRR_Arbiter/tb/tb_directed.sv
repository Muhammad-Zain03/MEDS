module tb_directed;
    parameter N = 4;
    parameter WEIGHT_W = 2;

    logic clk, rst;
    logic [N-1:0] req;
    logic [WEIGHT_W-1:0] weights [N-1:0];
    logic [N-1:0] grant_out;

    // Instantiate the RTL
weighted_rr_arbiter #(.N(N), .WEIGHT_W(WEIGHT_W)) dut (
    .clk(clk),
    .rst(rst),
    .req(req),
    .weights(weights),
    .grant_out(grant_out)
);

    // Clock Generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

    // Test Sequence
initial begin
    $display("----------------------------------------");
    $display("        STARTING DIRECTED TESTS");
    $display("----------------------------------------");

        // Test 1: Reset and Back-to-Back Resets
    $display("\n[TEST] Back-to-back reset assertions");
    rst = 1; req = 4'b0000;
    weights[0] = 2; weights[1] = 2; weights[2] = 2; weights[3] = 2;
    @(posedge clk); @(posedge clk);
    rst = 0; @(posedge clk);
    rst = 1; @(posedge clk);
    rst = 0; @(posedge clk);
    if (grant_out == 0) $display("PASS: Grant valid is 0 after resets");
    else $display("FAIL: Grant asserted unexpectedly");

        // Test 2: No requests active
    $display("\n[TEST] No requests active");
    req = 4'b0000;
    repeat(3) @(posedge clk);
    if (grant_out == 0) $display("PASS: Grant valid must be 0");
    else $display("FAIL: Grant asserted without request");

        // Test 3: Single requester active
    $display("\n[TEST] Single requester active (Req 1)");
    req = 4'b0010; // Only requester 1
    repeat(5) @(posedge clk);
    if (grant_out == 4'b0010) $display("PASS: Single requester gets every grant");
    else $display("FAIL: Grant not correctly assigned to single active requester");

        // Test 4: Mid-rotation deassert / Dropped Credit
    $display("\n[TEST] Mid-rotation deassert (Weight > 1)");
    req = 4'b1111; 
    weights[2] = 3; // Give requester 2 a weight of 3
        // Wait until requester 2 gets granted
    wait(grant_out == 4'b0100);
    @(posedge clk);
    req[2] = 0; // Drop request early
    @(posedge clk); 
    #1; // ADD THIS DELAY! Wait 1ns into the new cycle to read settled outputs
    if (grant_out !== 4'b0100) 
        $display("[PASS] Unused credit correctly dropped, priority passed at time=%0t", $time);
    else 
        $display("[FAIL] Requester banked unused credits at time=%0t", $time);
   

    $display("\n----------------------------------------");
    $display("   DIRECTED TESTS COMPLETE");
    $display("----------------------------------------");
    $finish;
end
endmodule