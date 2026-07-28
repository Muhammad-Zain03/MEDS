module priority_rotator #(
    parameter N = 4 //Number of requesters
)(
    input  logic [N-1:0]         req,
    input  logic [$clog2(N)-1:0] ptr,
    output logic [$clog2(N)-1:0] index_out,
    output logic                 grant
);

    logic [2*N-1:0] req_extended;
    logic [2*N-1:0] req_rotated;
    logic [$clog2(N)-1:0] priority_index;

    assign req_extended = {req, req}; 
    assign req_rotated = req_extended >> ptr;

    always_comb begin
        priority_index = 0;
        grant = 1'b1;
        
        casez (req_rotated[N-1:0])
            4'b???1: priority_index = 0;
            4'b??10: priority_index = 1;
            4'b?100: priority_index = 2;
            4'b1000: priority_index = 3;
            default: begin
                priority_index = 0;
                grant = 1'b0;
            end
        endcase
    end

    assign index_out = (priority_index + ptr) % N;

endmodule