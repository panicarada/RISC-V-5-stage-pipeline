`include "define.vh"
`include "controller.v"
`include "immediate_generator.v"
`include "registers.v"
module instruction_decoder (
    input clk,
    input rst,
    input cpu_en,

    // from IF
    input [`INST_WIDTH - 1 : 0] instruction,

    // from WB
    input is_write_regs, // 是否要写入寄存器
    input [`REGS_WIDTH - 1 : 0] write_regs_address, // 写入寄存器的位置
    input [`DATA_WIDTH - 1 : 0] write_regs_data, // 写入寄存器的数据

    output [`REGS_WIDTH - 1 : 0] rd_address,
    output [`REGS_WIDTH - 1 : 0] rs1_address,
    output [`REGS_WIDTH - 1 : 0] rs2_address,

    output [`DATA_WIDTH - 1 : 0] rs1_data, // 操作�?1
    output [`DATA_WIDTH - 1 : 0] rs2_data,

    output [`DATA_WIDTH - 1 : 0] immediate, // 立即�?
    
    output [`ALU_B_OPTION_WIDTH - 1 : 0] ALU_B_option, // ALU B输入的�?�择信号
    output [`ALU_OPTION_WIDTH - 1 : 0] ALU_option, // ALU操作选项

    output [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type,

    output [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] mem_to_regs_option, // MEM阶段数据送到instruction decoder阶段的�?�项

    output is_write_mem_future, // 是否要写入DM
    output is_write_regs_future, // 是否要写入寄存器

    output [`DATA_WIDTH * (`REGS_NUM - 1) - 1 : 0] flatten_registers
);
    // wire [`REGS_WIDTH - 1 : 0] rs1_address;
    // wire [`REGS_WIDTH - 1 : 0] rs2_address;
    assign rd_address = instruction[`RD_RANGE];
    assign rs1_address = instruction[`RS1_RANGE];
    assign rs2_address = instruction[`RS2_RANGE];

    registers registers (  
        .clk(clk),
        .cpu_en(cpu_en),
        .rst(rst),
        .rs1_address(rs1_address),
        .rs2_address(rs2_address),

        .is_write_regs(is_write_regs),
        .write_address(write_regs_address),
        .write_data(write_regs_data),

        .rs1_data(rs1_data),
        .rs2_data(rs2_data),

        .flatten_registers(flatten_registers)
    );

    wire [`OP_WIDTH - 1 : 0] opcode;
    assign opcode = instruction[`OP_RANGE];
    wire [2 : 0] funct3;
    assign funct3 = instruction[`FUNCT3_RANGE];
    wire [`INST_TYPE_WIDTH - 1 : 0] instruction_type;

    wire is_use_rs1; // 当前指令是否使用rs1的数�?
    wire is_use_rs2; // 当前指令是否使用rs2的数�?
    controller controller (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(instruction[30]),

        .instruction_type(instruction_type),
        .ALU_B_option(ALU_B_option),
        .ALU_option(ALU_option),
        .branch_type(branch_type),
        
        .is_write_mem_future(is_write_mem_future),
        .is_write_regs_future(is_write_regs_future),

        .mem_to_regs_option(mem_to_regs_option),

        .is_use_rs1(is_use_rs1),
        .is_use_rs2(is_use_rs2)
    );

    immediate_generator immediate_generator (
        .instruction(instruction),
        .instruction_type(instruction_type),
        .immediate(immediate)
    );


endmodule //instruction_decoder