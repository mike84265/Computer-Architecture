module ALU(data1_i, data2_i, ALUCtrl_i, data_o, Zero_o);
input  [31:0] data1_i, data2_i;
input  [2:0]  ALUCtrl_i;
output [31:0] data_o;
output        Zero_o;

reg    [31:0] data_reg;
reg           Zero_reg;

assign data_o = data_reg;
assign Zero_o = Zero_reg;

`define AND 3'b000
`define OR  3'b001
`define ADD 3'b010
`define SUB 3'b110
`define SLT 3'b111
`define MUL 3'b011

always @ (data1_i or data2_i or ALUCtrl_i)
begin
    case (ALUCtrl_i)
        `AND: data_reg = data1_i & data2_i;
        `OR:  data_reg = data1_i | data2_i;
        `ADD: data_reg = data1_i + data2_i;
        `SUB: data_reg = data1_i - data2_i;
        `SLT: data_reg = (data1_i < data2_i)? 1 : 0;
        `MUL: data_reg = data1_i * data2_i;
    endcase
end
endmodule
