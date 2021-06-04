`include "define.vh"

module MEM_reg_WB (
    input clk,
    input cpu_en,
    input rst,

    input [`PC_WIDTH - 1 : 0] in_pc_4,
    input [`REGS_WIDTH - 1 : 0] in_rd_address,
    input [`DATA_WIDTH - 1 : 0] in_ALU_result,
    input [`DATA_WIDTH - 1 : 0] in_mem_read_data, // data memory读出的数据
    input [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] in_mem_to_regs_option,
    input in_is_write_regs_future, // 是否要写入寄存器
    input [`DATA_WIDTH - 1 : 0] in_immediate,
    input [`PC_WIDTH - 1 : 0] in_pc,
    input [`INST_WIDTH - 1 : 0] in_instruction,

    output reg [`INST_WIDTH - 1 : 0] out_instruction,

    output reg [`PC_WIDTH - 1 : 0] out_pc,

    output reg [`PC_WIDTH - 1 : 0] out_pc_4,
    output reg [`REGS_WIDTH - 1 : 0] out_rd_address,
    output reg [`DATA_WIDTH - 1 : 0] out_ALU_result,
    output reg [`DATA_WIDTH - 1 : 0] out_mem_read_data, // data memory读出的数据
    output reg [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] out_mem_to_regs_option,
    output reg out_is_write_regs_future, // 是否要写入寄存器

    output reg [`DATA_WIDTH - 1 : 0] out_immediate
);
    initial begin
        out_pc_4 = 0;
        out_rd_address = 0;
        out_ALU_result = 0;
        out_mem_read_data = 0;
        out_mem_to_regs_option = 0;
        out_is_write_regs_future = 0;
        out_immediate = 0;
        out_pc = 0;
        out_instruction = 0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out_pc_4 <= 0;
            out_rd_address <= 0;
            out_ALU_result <= 0;
            out_mem_read_data <= 0;
            out_mem_to_regs_option <= 0;
            out_is_write_regs_future <= 0;
            out_immediate <= 0;
            out_pc <= 0;
            out_instruction <= 0;
        end
        else if (cpu_en) begin
            out_pc_4 <= in_pc_4;
            out_rd_address <= in_rd_address;
            out_ALU_result <= in_ALU_result;
            out_mem_read_data <= in_mem_read_data;
            out_mem_to_regs_option <= in_mem_to_regs_option;
            out_is_write_regs_future <= in_is_write_regs_future;
            out_immediate <= in_immediate;

            out_pc <= in_pc;
            out_instruction <= in_instruction;
        end
    end

endmodule //MEM_reg_WB