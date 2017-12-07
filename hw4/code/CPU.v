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

wire   [31:0] inst, ALU_in1, currentPC, nextPC;
wire          RegDst, ALUSrc, RegWrite, Zero;
wire   [1:0]  ALUOp;
wire   [2:0]  ALUCtrl;
wire   [31:0] RSData, RTData, RDData, imm32;
wire   [4:0]  writeReg;


Control Control(
    .Op_i       (inst[31:26]),
    .RegDst_o   (RegDst),
    .ALUOp_o    (ALUOp),
    .ALUSrc_o   (ALUSrc),
    .RegWrite_o (RegWrite)
);

Adder Add_PC(
    .data1_in   (currentPC),
    .data2_in   (32'd4),
    .data_o     (nextPC)
);

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (nextPC),
    .pc_o       (currentPC)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (currentPC), 
    .instr_o    (inst)
);

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (inst[25:21]),
    .RTaddr_i   (inst[20:16]),
    .RDaddr_i   (writeReg), 
    .RDdata_i   (RDData),
    .RegWrite_i (RegWrite), 
    .RSdata_o   (RSData), 
    .RTdata_o   (RTData) 
);

MUX5 MUX_RegDst(
    .data1_i    (inst[20:16]),
    .data2_i    (inst[15:11]),
    .select_i   (RegDst),
    .data_o     (writeReg)
);

MUX32 MUX_ALUSrc(
    .data1_i    (RTData),
    .data2_i    (imm32),
    .select_i   (ALUSrc),
    .data_o     (ALU_in1)
);

Sign_Extend Sign_Extend(
    .data_i     (inst[15:0]),
    .data_o     (imm32)
);
  
ALU ALU(
    .data1_i    (RSData),
    .data2_i    (ALU_in1),
    .ALUCtrl_i  (ALUCtrl),
    .data_o     (RDData),
    .Zero_o     (Zero)
);

ALU_Control ALU_Control(
    .funct_i    (inst[5:0]),
    .ALUOp_i    (ALUOp),
    .ALUCtrl_o  (ALUCtrl)
);

endmodule

