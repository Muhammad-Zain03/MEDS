module weight_counter #(parameter WEIGHT_W = 2) //Programmable weight
(
    input  logic                clk,
    input  logic                rst,      
    input  logic                load_en,  
    input  logic                counter_en, 
    input  logic [WEIGHT_W-1:0] weight,   
    output logic                exhausted,
    output logic                last_grant
);

logic [WEIGHT_W-1:0] count;

always_ff @(posedge clk) begin
    if (rst) begin
        count <= '0;
    end 
    else if (load_en) begin
        count <= weight;
    end 
    else if (counter_en && count > 0) begin
        count <= count - 1;
    end
    else begin
        count <= count;
    end
end

assign exhausted = (count == 0);
assign last_grant = counter_en && (count == 1);

endmodule