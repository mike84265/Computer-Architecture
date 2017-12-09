module ALU_Control(funct_i, ALUOp_i, ALUCtrl_o);
input  [5:0] funct_i;
input  [1:0] ALUOp_i;
output [2:0] ALUCtrl_o;
// reg    [2:0] ALUCtrl_reg;

`define AND_Ctrl 3'b000
`define OR_Ctrl  3'b001
`define ADD_Ctrl 3'b010
`define SUB_Ctrl 3'b110
`define MUL_Ctrl 3'b011
`define SLT_Ctrl 3'b111

`define ADD_funct 6'b100000
`define SUB_funct 6'b100010
`define AND_funct 6'b100100
`define OR_funct  6'b100101
`define SLT_funct 6'b101010
`define MUL_funct 6'b011000

assign ALUCtrl_o = (ALUOp_i == 2'b00)? `ADD_Ctrl :
                   (ALUOp_i == 2'b01)? `SUB_Ctrl :
                   (ALUOp_i == 2'b10)? `OR_Ctrl  :
                   (funct_i == `ADD_funct)? `ADD_Ctrl :
                   (funct_i == `SUB_funct)? `SUB_Ctrl :
                   (funct_i == `AND_funct)? `AND_Ctrl :
                   (funct_i == `OR_funct)?  `OR_Ctrl  :
                   (funct_i == `SLT_funct)? `SLT_Ctrl :
                   (funct_i == `MUL_funct)? `MUL_Ctrl :
                   3'bx;
/*
always @ (funct_i or ALUOp_i)
begin
    case(ALUOp_i)
    2'b00: ALUCtrl_reg = `ADD_Ctrl;
    2'b01: ALUCtrl_reg = `SUB_Ctrl;
    2'b10: ALUCtrl_reg = `OR_Ctrl;
    default: 
        begin
        case(funct_i)
            `ADD_funct: ALUCtrl_reg = `ADD_Ctrl;
            `SUB_funct: ALUCtrl_reg = `SUB_Ctrl;
            `AND_funct: ALUCtrl_reg = `AND_Ctrl;
            `OR_funct:  ALUCtrl_reg = `OR_Ctrl;
            `SLT_funct: ALUCtrl_reg = `SLT_Ctrl;
            `MUL_funct: ALUCtrl_reg = `MUL_Ctrl;
            default: ALUCtrl_reg = 3'bx;
        endcase
        end
    endcase
end
*/

// assign ALUCtrl_o = ALUCtrl_reg;
endmodule
