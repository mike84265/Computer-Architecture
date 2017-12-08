module Hazard_Detection (
    ID_EX_MemRd_i, ID_EX_Rt_i,
    IF_ID_Rs_i, IF_ID_Rt_i,
    Stall_o, PCWrite_o
);

input           ID_EX_MemRd_i;
input   [4:0]   ID_EX_Rt_i, IF_ID_Rs_i, IF_ID_Rt_i;

output          Stall_o, PCWrite_o;

assign Stall_o = (ID_EX_MemRd_i) && ((ID_EX_Rt_i == IF_ID_Rs_i) || (ID_EX_Rt_i == IF_ID_Rt_i));
assign PCWrite_o = ~Stall_o;

endmodule
