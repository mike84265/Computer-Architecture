module IF_ID (
    clk_i, start_i,
    ID_Flush_i, PC_i, inst_i,
    ID_Flush_o, PC_o, inst_o
);

input         clk_i, start_i;
input         ID_Flush_i;
input  [31:0] PC_i, inst_i;
output        ID_Flush_o;
output [31:0] PC_o, inst_o;
reg           ID_Flush;
reg    [31:0] PC, inst;

assign ID_Flush_o = ID_Flush;
assign PC_o = PC;
assign inst_o = inst;

always @(posedge clk_i) begin
    if (start_i) begin
        PC <= PC_i;
        inst <= inst_i;
        ID_Flush <= ID_Flush_i;
    end
end

endmodule
