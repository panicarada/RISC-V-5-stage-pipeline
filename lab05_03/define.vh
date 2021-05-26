`define DEBUG

`define PC_WIDTH 32 // pc都是32位

`define INST_WIDTH 32 // 指令都是32位

`define DATA_WIDTH 32 // 数据都是32位

`define REGS_WIDTH 5 // 总共有2^5 = 32个寄存器
`define REGS_NUM (1 << `REGS_WIDTH)

// rs1, rs2, rd地址在指令中的位置
`define RS2_RANGE (31-7):(31-7-4)
`define RS1_RANGE (31-7-5):(31-7-5-4)
`define RD_RANGE (31-7-5-5-3):(31-7-5-5-3-4)
`define FUNCT3_RANGE (31-7-5-5):(31-7-5-5-2)

// 指令类型
`define INST_TYPE_WIDTH 3
`define INST_TYPE_R 0
`define INST_TYPE_I 1
`define INST_TYPE_S 2
`define INST_TYPE_SB 3
`define INST_TYPE_U 4
`define INST_TYPE_JAL 5
`define INST_TYPE_JALR 6

// op code编码
`define OP_WIDTH 7
`define OP_RANGE 6:0
`define OP_R_TYPE 7'b0110011
// lb, lh, lw, lb, lbu, lhu, lwu
`define OP_LOAD 7'b0000011
// addi, slli, xori, srli, srai, ori, andi
`define OP_I_ARITHMETIC 7'b0010011  
`define OP_JALR 7'b1100111
// sb, sh, sw, sd
`define OP_S_TYPE 7'b0100011
// beq, bne, blt, bge, bltu, bgeu
`define OP_SB_TYPE 7'b1100011
// lui
`define OP_U_TYPE 7'b0110111
// jal
`define OP_JAL 7'b1101111


// ALU的B输入来源选择
`define ALU_B_OPTION_WIDTH 1
`define ALU_B_OPTION_REGS 0
`define ALU_B_OPTION_IMM 1 // 立即数

// ALU操作选择
`define ALU_OPTION_WIDTH 3
`define ALU_OPTION_ADD 0
`define ALU_OPTION_SUB 1
`define ALU_OPTION_SLL 2
`define ALU_OPTION_SRL 3
`define ALU_OPTION_AND 4
`define ALU_OPTION_OR 5
`define ALU_OPTION_XOR 6




// 跳转操作类型
`define BRANCH_TYPE_WIDTH 3
`define BRANCH_TYPE_NONE 0
`define BRANCH_TYPE_BEQ 1
`define BRANCH_TYPE_BNE 2
`define BRANCH_TYPE_JAL 3
`define BRANCH_TYPE_JALR 4


// 区别各个R指令的{funct3, instruction[30]}
`define FUNCT_ADD {3'b000, 1'b0}
`define FUNCT_SUB {3'b000, 1'b1}
`define FUNCT_SLL {3'b001, 1'b0}
`define FUNCT_XOR {3'b100, 1'b0}
`define FUNCT_SRL {3'b101, 1'b0}
`define FUNCT_SRA {3'b101, 1'b0}
`define FUNCT_OR  {3'b110, 1'b0}
`define FUNCT_AND {3'b111, 1'b0}

`define FUNCT3_ADDI 3'b000
`define FUNCT3_SLLI 3'b001
`define FUNCT3_XORI 3'b100
`define FUNCT3_ANDI 3'b111
`define FUNCT3_ORI  3'b110

// 区别各个load指令的funct3
`define FUNCT3_LW {3'b010}

// MEM阶段数据送到instruction decoder阶段的选项
`define MEM_TO_REGS_OPTION_WIDTH 2
`define MEM_TO_REGS_OPTION_ALU 0
`define MEM_TO_REGS_OPTION_MEM_READ 1 // 从data memory读取的值
`define MEM_TO_REGS_OPTION_PC_4 2 // 比如jal / jalr指令，把pc_4写入rd
`define MEM_TO_REGS_OPTION_IMM 3 // lui指令，把20位立即数放到rd高位，第12位补0

// sb指令区分
`define FUNCT3_BEQ 3'b000
`define FUNCT3_BNE 3'b001