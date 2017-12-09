module ID_EX (
    clk_i, start_i,

    ALUSrc_i, ALUOp_i, RegDst_i, MemRd_i, MemWr_i, MemtoReg_i, RegWrite_i, Data1_i, Data2_i, Rs_i, Rt_i, Rd_i, imm_i, funct_i,

    ALUSrc_o, ALUOp_o, RegDst_o, MemRd_o, MemWr_o, MemtoReg_o, RegWrite_o, Data1_o, Data2_o, Rs_o, Rt_o, Rd_o, imm_o, funct_o
);

input           clk_i, start_i;
input           ALUSrc_i, RegDst_i, MemRd_i, MemWr_i, MemtoReg_i, RegWrite_i; 
input  [1:0]    ALUOp_i;
input  [31:0]   Data1_i, Data2_i, imm_i;
input  [4:0]    Rs_i, Rt_i, Rd_i;
input  [5:0]    funct_i;

output          ALUSrc_o, RegDst_o, MemRd_o, MemWr_o, MemtoReg_o, RegWrite_o; 
output [1:0]    ALUOp_o;
output [31:0]   Data1_o, Data2_o, imm_o;
output [4:0]    Rs_o, Rt_o, Rd_o;
output [5:0]    funct_o;

reg             ALUSrc,   RegDst,   MemRd,   MemWr,   MemtoReg,   RegWrite;
reg    [1:0]    ALUOp;
reg    [31:0]   Data1,   Data2,   imm;
reg    [4:0]    Rs,   Rt,   Rd;
reg    [5:0]    funct;

assign ALUSrc_o = ALUSrc;
assign RegDst_o = RegDst;
assign MemRd_o = MemRd;
assign MemWr_o = MemWr;
assign MemtoReg_o = MemtoReg;
assign RegWrite_o = RegWrite;
assign ALUOp_o = ALUOp;
assign Data1_o = Data1;
assign Data2_o = Data2;
assign imm_o = imm;
assign Rs_o = Rs;
assign Rt_o = Rt;
assign Rd_o = Rd;
assign funct_o = funct;

always @ (posedge clk_i) begin
    if (start_i) begin
        ALUSrc <= ALUSrc_i;
        RegDst <= RegDst_i;
        MemRd <= MemRd_i;
        MemWr <= MemWr_i;
        MemtoReg <= MemtoReg_i;
        RegWrite <= RegWrite_i;
        ALUOp <= ALUOp_i;
        Data1 <= Data1_i;
        Data2 <= Data2_i;
        imm <= imm_i;
        Rs <= Rs_i;
        Rt <= Rt_i;
        Rd <= Rd_i;
        funct <= funct_i;
    end
end

endmodule
