module MUX4(data00_i, data01_i, data10_i, data11_i, select_i, data_o);
input  [31:0] data00_i, data01_i, data10_i, data11_i;
input  [1:0]  select_i;
output [31:0] data_o;

assign data_o = (select_i == 2'b00)? data00_i :
                (select_i == 2'b01)? data01_i :
                (select_i == 2'b10)? data10_i :
                (select_i == 2'b11)? data11_i : 32'bx;
endmodule
