module weighted_rr_arbiter #(
    parameter N = 4,
    parameter WEIGHT_W = 2
)(
    input  logic                      clk,
    input  logic                      rst,
    input  logic [N-1:0]              req,
    input  var logic [WEIGHT_W-1:0]   weights [N-1:0],
    output logic [N-1:0]              grant_out
);

typedef enum logic {
    IDLE = 1'b0,
    GRANTING = 1'b1
} state_t;

state_t present_state, next_state;

logic [N-1:0]         next_grant;
logic [$clog2(N)-1:0] ptr_reg, next_ptr;
    
    // Datapath wires
logic [$clog2(N)-1:0] index_out;
logic                 grant;
logic                 counter_load, counter_en;
logic                 exhausted, last_grant;
logic [WEIGHT_W-1:0]  active_weight;

    // --- Datapath Instantiations ---
priority_rotator #(.N(N)) u_rotator (
    .req(req),
    .ptr(ptr_reg),
    .index_out(index_out),
    .grant(grant)
);

weight_counter #(.WEIGHT_W(WEIGHT_W)) u_counter (
    .clk(clk),
    .rst(rst),
    .load_en(counter_load),
    .counter_en(counter_en),
    .weight(active_weight),
    .exhausted(exhausted),
    .last_grant(last_grant)
);

always_ff @(posedge clk) begin
    if(rst) begin
        present_state <= IDLE;
        ptr_reg       <= '0;
        grant_out     <= '0;
    end
    else begin
        present_state <= next_state;
        ptr_reg       <= next_ptr;
        grant_out     <= next_grant;
    end
end

always_comb begin
    next_state    = present_state;
    next_ptr      = ptr_reg;
    next_grant    = '0; 
        
    counter_load  = 1'b0;
    counter_en    = 1'b0;
    active_weight = weights[index_out];

    case(present_state)
        IDLE: begin
            if(req != 0 && grant) begin
                next_state = GRANTING;
                next_grant[index_out] = 1'b1;
                counter_load = 1'b1;
                next_ptr = (index_out + 1) % N;
            end
            else begin
                next_state = IDLE;
            end
        end

        

        GRANTING: begin
            logic current_req_active;
            current_req_active = |(req & grant_out);

            if(current_req_active) begin
                counter_en = 1'b1; 
                    
                if(last_grant) begin
                    next_state = IDLE;
                    next_grant = '0;
                end
                else begin
                    next_grant = grant_out; 
                end
            end 
            else begin
                next_state = IDLE;
                next_grant = '0;
            end
        end
    endcase
end
endmodule