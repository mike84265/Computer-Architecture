module Data_Memory
(
    addr_i, 
    MemWrite_i,
    data_i,
    data_o
);

// Interface
input   [31:0]      addr_i;
input               MemWrite_i;
input   [31:0]      data_i;
output  [31:0]      data_o;

// Instruction memory
reg     [31:0]     memory  [0:1023];

assign  data_o = memory[addr_i>>2];  
if (MemWrite_i) begin
    memory[addr_i >> 2] <= data_i;
end

endmodule
