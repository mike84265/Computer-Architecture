module Adder(data1_in, data2_in, data_o);

input  [31:0] data1_in, data2_in; 
output [31:0] data_o;
wire co;

assign {co, data_o} = data1_in + data2_in;
endmodule
