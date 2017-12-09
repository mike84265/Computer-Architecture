module IF_ID (
    clk_i, start_i, flush_i, stall_i, 
    inst_i,
    inst_o
);

input         clk_i, start_i, flush_i, stall_i;
input  [31:0] inst_i;
output [31:0] inst_o;
reg    [31:0] inst;

assign inst_o = inst;

always @(posedge clk_i) begin
    if (start_i) begin
        if (flush_i) begin
            inst <= 32'b0;
        end
        else if (~stall_i) begin
            inst <= inst_i;
        end
    end
end


endmodule
