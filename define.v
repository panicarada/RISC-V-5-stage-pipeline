`define DEBUG

`define PC_WIDTH 32
`define INST_WIDTH 32
`define DATA_WIDTH 32
// reg file有2^5 = 32个寄存器
`define REGS_WIDTH 5
`define REGS_NUM 32


// ALU
// ALU option输入宽度
`define ALU_OPTION_WIDTH 4
// 不同option对应的ALU操作
`define ALU_AND 4'b0000
`define ALU_OR  4'b0001
`define ALU_ADD 4'b0010
`define ALU_SUB 4'b0110
`define ALU_SLT 4'b0111 // set less than


`define TYPE_WIDTH 3
`define R_TYPE 3'b000
`define I_TYPE 3'b001
`define S_TYPE 3'b010
`define SB_TYPE 3'b011
`define U_TYPE 3'b100
`define UJ_TYPE 3'b101

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
`define OP_UJ_TYPE 7'b1101111

`define FUNCT7_RANGE (31):(31-6)
`define RS2_RANGE (31-7):(31-7-4)
`define RS1_RANGE (31-7-5):(31-7-5-4)
`define FUNCT3_RANGE (31-7-5-5):(31-7-5-5-2)
`define RD_RANGE (31-7-5-5-3):(31-7-5-5-3-4)
// 格式为{funct3, funct7[6:3], funct7[2:0]}
`define FUNCT_ADD {3'b000, 4'b0000, 3'b000}
`define FUNCT_SUB {3'b000, 4'b0100, 3'b000}
`define FUNCT_SLL {3'b001, 4'b0000, 3'b000}
`define FUNCT_XOR {3'b100, 4'b0000, 3'b000}
`define FUNCT_SRL {3'b101, 4'b0000, 3'b000}
`define FUNCT_SRA {3'b101, 4'b0000, 3'b000}
`define FUNCT_OR  {3'b110, 4'b0000, 3'b000}
`define FUNCT_AND {3'b111, 4'b0000, 3'b000}


`define LOAD_IMM_RANGE (31):(31-11)
`define FUNCT3_LB 3'b000
`define FUNCT3_LH 3'b001
`define FUNCT3_LW 3'b010
`define FUNCT3_LD 3'b011


// A_option / B_option的选项
`define A_OPTION_WIDTH 3
`define B_OPTION_WIDTH 3
`define A_REGS 0
`define B_REGS 0
`define EXE_ALU 1
`define MEM_ALU 2
`define MEM_READ 3
`define IMMEDIATE 4   // immediate
`define MEM_READ_FORWARD_EXE 5 // read memory access forward to execution


`define FUNCT3_ADDI 3'b000
`define FUNCT3_SLLI 3'b001
`define ADDI_IMM_RANGE `LOAD_IMM_RANGE


`define SB_IMM_RANGE_1 31 // offset[12]
`define SB_IMM_RANGE_2 7  // offset[11]
`define SB_IMM_RANGE_3 (30):(30-4) // offset[10:5]
`define SB_IMM_RANGE_4 (7+5):(7+1) // offset[4:1]
`define FUNCT3_BEQ 3'b000
`define FUNCT3_BNE 3'b001

`define BRANCH_OPTION_WIDTH 3
`define BRANCH_NA  3'b000 // 并没有branch
`define BRANCH_BEQ 3'b001 
`define BRANCH_BNE 3'b010


// S type
`define S_IMM_RANGE_HIGH (31):(31-6) // imm[11:5]
`define S_IMM_RANGE_LOW  (7+4):(7) // imm[4:0]
`define FUNCT3_SW 3'b010