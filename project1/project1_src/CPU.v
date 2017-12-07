module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input         clk_i;
input         rst_i;
input         start_i;

wire   [31:0] IF_inst, ALU_in1, currentPC, nextPC;
wire   [31:0] ID_inst, ID_PC;
wire          ID_ALUSrc, ID_RegWrite, ID_RegDst, ID_MemRd, ID_MemWr, ID_Branch, ID_Jump, ID_MemtoReg, ID_RegWrite;
wire          EX_ALUSrc, EX_RegWrite, EX_RegDst, EX_MemRd, EX_MemWr, EX_Branch, EX_Jump, EX_MemtoReg, EX_RegWrite;
wire   [1:0]  ID_ALUOp;
wire   [1:0]  EX_ALUOp;
wire   [2:0]  EX_ALUCtrl;
wire   [31:0] ID_RsData, ID_RtData, ID_RdData, ID_imm32;
wire   [31:0] EX_RsData, EX_RtData, EX_RdData, EX_imm32, EX_ALUin1, EX_ALUin2, EX_ALUinB, EX_ALUResult;
wire   [4:0]  EX_Rs, EX_Rt, EX_Rd, EX_WriteReg;
wire   [5:0]  EX_funct;
wire   [1:0]  EX_ForwardA, EX_ForwardB;
wire          MEM_MemRd, MEM_MemWr, MEM_Branch, MEM_MemtoReg, MEM_RegWrite;
wire   [31:0] MEM_ALUResult, MEM_Data;
wire   [4:0]  MEM_Rt, MEM_WriteReg;
wire          WB_MemtoReg, WB_RegWrite;
wire   [31:0] WB_ALUResult, WB_MemData, WB_WriteData;
wire   [4:0]  WB_RegAddr;

Instruction_Memory Instruction_Memory(
    .addr_i     (currentPC), 
    .instr_o    (IF_inst)
);

IF_ID IF_ID(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .IF_ID_Write_i  (),
    .IF_Flush_i     (),
    .PC_i           (currentPC),
    .inst_i         (IF_inst),
    .PC_o           (ID_PC),
    .inst_o         (ID_inst),
);

ID_EX ID_EX(
    .clk_i          (clk_i),
    .ALUSrc_i       (ID_ALUSrc),
    .ALUOp_i        (ID_ALUOp),
    .RegDst_i       (ID_RegDst),
    .MemRd_i        (ID_MemRd),
    .MemWr_i        (ID_MemWr),
    .Branch_i       (ID_Branch),
    .MemtoReg_i     (ID_MemtoReg),
    .RegWrite_i     (ID_RegWrite),
    .Data1_i        (ID_RsData),
    .Data2_i        (ID_RtData),
    .Rs_i           (ID_inst[25:21]),
    .Rt_i           (ID_inst[20:16]),
    .Rd_i           (ID_inst[15:11]),
    .imm_i          (ID_imm32),
    .funct_i        (ID_inst[5:0]),

    .ALUSrc_o       (EX_ALUSrc),
    .ALUOp_o        (EX_ALUOp),
    .RegDst_o       (EX_RegDst),
    .MemRd_o        (EX_MemRd),
    .MemWr_o        (EX_MemWr),
    .Branch_o       (EX_Branch),
    .MemtoReg_o     (EX_MemtoReg),
    .RegWrite_o     (EX_RegWrite),
    .Data1_o        (EX_RsData),
    .Data2_o        (EX_RtData),
    .Rs_o           (EX_Rs),
    .Rt_o           (EX_Rt),
    .Rd_o           (EX_Rd),
    .imm_o          (EX_imm32),
    .funct_o        (EX_funct)
);

EX_MEM EX_MEM(
    .clk_i          (clk_i),

    .MemRd_i        (EX_MemRd),
    .MemWr_i        (EX_MemWr),
    .Branch_i       (EX_Branch),
    .MemtoReg_i     (EX_MemtoReg),
    .RegWrite_i     (EX_RegWrite),
    .ALUResult_i    (EX_ALUResult),
    .WriteReg_i     (EX_WriteReg),
    .Rt_i           (EX_Rt),
    .MemData_i      (EX_RtData),

    .MemRd_o        (MEM_MemRd),
    .MemWr_o        (MEM_MemWr),
    .Branch_o       (MEM_Branch),
    .MemtoReg_o     (MEM_MemtoReg),
    .RegWrite_o     (MEM_RegWrite),
    .ALUResult_o    (MEM_ALUResult),
    .WriteReg_o     (MEM_WriteReg),
    .Rt_o           (MEM_Rt),
    .MemData_o      (MEM_Data)
);

MEM_WB MEM_WB(
    .clk_i          (clk_i),

    .MemtoReg_i     (MEM_MemtoReg),
    .RegWrite_i     (MEM_RegWrite),
    .MemData_i      (MEM_Data),
    .ALUResult_i    (MEM_ALUResult),
    .RegAddr_i      (MEM_WriteReg),

    .MemtoReg_o     (WB_MemtoReg),
    .RegWrite_o     (WB_RegWrite),
    .MemData_o      (WB_MemData),
    .ALUResult_o    (WB_ALUResult),
    .RegAddr_o      (WB_RegAddr)

);


Control Control(
    .Op_i           (ID_inst[31:26]),
    .ALUSrc_o       (ID_ALUSrc),
    .ALUOp_o        (ID_ALUOp),
    .RegDst_o       (ID_RegDst),
    .MemRd_o        (ID_MemRd),
    .MemWr_o        (ID_MemWr),
    .Branch_o       (ID_Branch),
    .Jump_o         (ID_Jump),
    .MemtoReg_o     (ID_MemtoReg),
    .RegWrite_o     (ID_RegWrite)
);

Adder Add_PC(
    .data1_in       (currentPC),
    .data2_in       (32'd4),
    .data_o         (nextPC)
);

PC PC(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        (start_i),
    .pc_i           (nextPC),
    .pc_o           (currentPC)
);

Registers ID_Registers(
    .clk_i          (clk_i),
    .RSaddr_i       (ID_inst[25:21]),
    .RTaddr_i       (ID_inst[20:16]),
    .RDaddr_i       (ID_writeReg), 
    .RDdata_i       (ID_RdData),
    .RegWrite_i     (ID_RegWrite), 
    .RSdata_o       (ID_RsData), 
    .RTdata_o       (ID_RtData) 
);

MUX5 MUX_RegDst(    
    .data1_i        (EX_Rt),
    .data2_i        (EX_Rd),
    .select_i       (EX_RegDst),
    .data_o         (EX_WriteReg)
);

MUX4 MUX_ALUSrc1 (
    .data00_i       (EX_RsData),
    .data01_i       (WB_WriteData),
    .data10_i       (MEM_ALUResult),
    .data11_i       (32'bx)
    .select_i       (EX_ForwardA),
    .data_o         (EX_ALUin1)
);

MUX4 MUX_ALUSrc2 (
    .data00_i       (EX_RtData),
    .data01_i       (WB_WriteData),
    .data10_i       (MEM_ALUResult),
    .data11_i       (32'bx)
    .select_i       (EX_ForwardB),
    .data_o         (EX_ALUinB)
);

Forwarding Forwarding (
    .EX_MEM_RegWrite_i  (MEM_RegWrite),
    .EX_MEM_Rd_i        (MEM_Rd),

    .MEM_WB_RegWrite_i  (WB_RegWrite),
    .MEM_WB_Rd_i        (WB_Rd),

    .ID_EX_Rs_i         (EX_Rs),
    .ID_EX_Rt_i         (EX_Rt),

    .ForwardA_o         (EX_ForwardA),
    .ForwardB_o         (EX_ForwardB)
);

MUX32 MUX_ALUSrc(
    .data1_i        (EX_ALUinB),
    .data2_i        (EX_imm32),
    .select_i       (EX_ALUSrc),
    .data_o         (EX_ALUin2)
);

Sign_Extend Sign_Extend(
    .data_i         (ID_inst[15:0]),
    .data_o         (ID_imm32)
);
  
ALU ALU(
    .data1_i        (EX_ALUin1),
    .data2_i        (EX_ALUin2),
    .ALUCtrl_i      (EX_ALUCtrl),
    .data_o         (EX_ALUResult)
);

ALU_Control ALU_Control(
    .funct_i        (EX_funct),
    .ALUOp_i        (EX_ALUOp),
    .ALUCtrl_o      (EX_ALUCtrl)
);

Data_Memory Data_Memory(
    .addr_i         (MEM_ALUResult),
    .data_o         (MEM_Data),
);

MUX32 MUX_WBSrc (
    .data1_i        (WB_ALUResult),
    .data2_i        (WB_MemData),
    .select_i       (WB_MemtoReg),
    .data_o         (WB_WriteData)
);

Registers WB_Registers(
    .clk_i          (clk_i),
    .RSaddr_i       (5'bx),
    .RTaddr_i       (5'bx),
    .RDaddr_i       (WB_RegAddr), 
    .RDdata_i       (WB_WriteData),
    .RegWrite_i     (WB_RegWrite), 
    .RSdata_o       (5'bx), 
    .RTdata_o       (5'bx) 
);


endmodule

