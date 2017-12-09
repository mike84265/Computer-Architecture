module MEM_WB (
    clk_i, start_i,

    MemtoReg_i, RegWrite_i, ALUResult_i, MemData_i, RegAddr_i,
    MemtoReg_o, RegWrite_o, ALUResult_o, MemData_o, RegAddr_o
);

input clk_i, start_i;

input           MemtoReg_i, RegWrite_i;
input  [31:0]   ALUResult_i, MemData_i;
input  [4:0]    RegAddr_i;
output          MemtoReg_o, RegWrite_o;
output [31:0]   ALUResult_o, MemData_o;
output  [4:0]   RegAddr_o;

reg             MemtoReg  , RegWrite  ;
reg    [31:0]   ALUResult  , MemData  ;
reg     [4:0]   RegAddr  ;

assign MemtoReg_o = MemtoReg;
assign RegWrite_o = RegWrite;
assign ALUResult_o = ALUResult;
assign MemData_o = MemData;
assign RegAddr_o = RegAddr;

always @(posedge clk_i) begin
    if (start_i) begin
        MemtoReg <= MemtoReg_i;
        RegWrite <= RegWrite_i;
        ALUResult <= ALUResult_i;
        MemData <= MemData_i;
        RegAddr <= RegAddr_i;
    end
end

endmodule
