module Control(Op_i, NoOp_i, ALUSrc_o, ALUOp_o, RegDst_o, MemRd_o, MemWr_o, Branch_o, Jump_o, MemtoReg_o, RegWrite_o);
input  [5:0] Op_i;
input        NoOp_i;
output [1:0] ALUOp_o;
output       ALUSrc_o, RegDst_o, MemRd_o, MemWr_o, Branch_o, Jump_o, MemtoReg_o, RegWrite_o;

`define Rtype_Op 6'b000000
`define addi_Op  6'b001000
`define lw_Op    6'b100011
`define sw_Op    6'b101011
`define beq_Op   6'b000100
`define jump_Op  6'b000010

assign RegDst_o     = (~NoOp_i) && (Op_i == `Rtype_Op);
assign ALUSrc_o     = (~NoOp_i) && ((Op_i == `addi_Op) || (Op_i == `lw_Op) || (Op_i == `sw_Op));
assign MemRd_o      = (~NoOp_i) && (Op_i == `lw_Op);
assign MemWr_o      = (~NoOp_i) && (Op_i == `sw_Op);
assign Branch_o     = (~NoOp_i) && (Op_i == `beq_Op);
assign Jump_o       = (~NoOp_i) && (Op_i == `jump_Op);
assign RegWrite_o   = (~NoOp_i) && ((Op_i == `Rtype_Op) || (Op_i == `addi_Op) || (Op_i == `lw_Op));

assign ALUOp_o[1] = (Op_i == `Rtype_Op);
assign ALUOp_o[0] = (Op_i == `Rtype_Op) || (Op_i == `beq_Op);

endmodule
