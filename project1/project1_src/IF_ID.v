module IF_ID (
    clk_i, rst_i,
    IF_ID_Write_i, IF_Flush_i,
    PC_i, inst_i,
    PC_o, inst_o
);

input         clk_i, rst_i;
input         IF_ID_Write_i, IF_Flush_i;
input  [31:0] PC_i, inst_i;
output [31:0] PC_o, inst_o;
reg    [31:0] PC, inst;

assign PC_o = PC;
assign inst_o = inst;

always @(posedge clk_i or negedge rst_i) begin
    if (rst_i == 0) begin
        PC <= 32'b0;
        inst <= 32'b0;
    end
    else if (IF_ID_Write_i) begin
        PC <= PC_i;
        inst <= inst_i;
    end
end

endmodule
