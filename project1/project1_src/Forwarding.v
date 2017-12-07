module Forwarding (
    EX_MEM_RegWrite_i,
    EX_MEM_Rd_i,

    MEM_WB_RegWrite_i, 
    MEM_WB_Rd_i,

    ID_EX_Rs_i, ID_EX_Rt_i,

    ForwardA_o, ForwardB_o
);

input           EX_MEM_RegWrite_i, MEM_WB_RegWrite_i;
input  [4:0]    EX_MEM_Rd_i, MEM_WB_Rd_i, ID_EX_Rs_i, ID_EX_Rt_i;
output [1:0]    ForwardA_o, ForwardB_o;

assign ForwardA_o[1] = (EX_MEM_RegWrite_i) && (EX_MEM_Rd_i != 0) && (EX_MEM_Rd_i == ID_EX_Rs_i);
assign ForwardB_o[1] = (EX_MEM_RegWrite_i) && (EX_MEM_Rd_i != 0) && (EX_MEM_Rd_i == ID_EX_Rt_i);

assign ForwardA_o[0] = (MEM_WB_RegWrite_i) && (MEM_WB_Rd_i != 0) && (EX_MEM_Rd_i != ID_EX_Rs_i) && (MEM_WB_Rd_i == ID_EX_Rs_i);
assign ForwardB_o[0] = (MEM_WB_RegWrite_i) && (MEM_WB_Rd_i != 0) && (EX_MEM_Rd_i != ID_EX_Rt_i) && (MEM_WB_Rd_i == ID_EX_Rt_i);

endmodule
