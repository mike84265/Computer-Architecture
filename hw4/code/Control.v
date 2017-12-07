module Control(Op_i, RegDst_o, ALUOp_o, ALUSrc_o, RegWrite_o);
input  [5:0] Op_i;
output [1:0] ALUOp_o;
output       RegDst_o, ALUSrc_o, RegWrite_o;

`define Rtype_Op 6'b000000
`define addi_Op  6'b001000

assign RegDst_o = (Op_i == `Rtype_Op);
assign ALUSrc_o = (Op_i == `addi_Op);
assign RegWrite_o = (Op_i == `Rtype_Op) || (Op_i == `addi_Op);

assign ALUOp_o[1] = (Op_i == `Rtype_Op) || (Op_i != `addi_Op);
assign ALUOp_o[0] = (Op_i == `Rtype_Op) || (Op_i != `addi_Op);

endmodule
