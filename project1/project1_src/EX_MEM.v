module EX_MEM (
    clk_i, start_i,

    MemRd_i, MemWr_i, MemtoReg_i, RegWrite_i, ALUResult_i, MemData_i, WriteReg_i, Rt_i,
    
    MemRd_o, MemWr_o, MemtoReg_o, RegWrite_o, ALUResult_o, MemData_o, WriteReg_o, Rt_o
);

input           clk_i, start_i;

input           MemRd_i, MemWr_i, MemtoReg_i, RegWrite_i;
input  [31:0]   ALUResult_i, MemData_i;
input  [4:0]    WriteReg_i, Rt_i;

output          MemRd_o, MemWr_o, MemtoReg_o, RegWrite_o;
output [31:0]   ALUResult_o, MemData_o;
output [4:0]    WriteReg_o, Rt_o;

reg             MemRd  , MemWr  , MemtoReg  , RegWrite  ; 
reg    [31:0]   ALUResult  , MemData  ;
reg    [4:0]    WriteReg  , Rt  ;

assign MemRd_o = MemRd;
assign MemWr_o = MemWr;
assign MemtoReg_o = MemtoReg;
assign RegWrite_o = RegWrite;
assign ALUResult_o = ALUResult;
assign MemData_o = MemData;
assign WriteReg_o = WriteReg;
assign Rt_o = Rt;

always @(posedge clk_i) begin
    if (start_i) begin
        MemRd <= MemRd_i;
        MemWr <= MemWr_i;
        MemtoReg <= MemtoReg_i;
        RegWrite <= RegWrite_i;
        ALUResult <= ALUResult_i;
        Rt <= Rt_i;
        WriteReg <= WriteReg_i;
        MemData <= MemData_i;
    end
end

endmodule
