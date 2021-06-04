`include "define.vh"

module EXE_reg_MEM (
    input clk,
    input cpu_en,
    input rst,

    input [`PC_WIDTH - 1 : 0] in_branch_pc,
    input [`PC_WIDTH - 1 : 0] in_pc,

    input [`PC_WIDTH - 1 : 0] in_pc_4,
    input [`REGS_WIDTH - 1 : 0] in_rd_address,
    input in_is_zero,
    input [`DATA_WIDTH - 1 : 0] in_ALU_result,
    input [`DATA_WIDTH - 1 : 0] in_rs2_data,
    input [`BRANCH_TYPE_WIDTH - 1 : 0] in_branch_type,
    input in_is_write_mem_future,
    input [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] in_mem_to_regs_option,
    input in_is_write_regs_future,
    input [`DATA_WIDTH - 1 : 0] in_immediate,
    input [`INST_WIDTH - 1 : 0] in_instruction,

    output reg [`INST_WIDTH - 1 : 0] out_instruction,
    output reg [`PC_WIDTH - 1 : 0] out_pc,
    output reg [`PC_WIDTH - 1 : 0] out_branch_pc,
    output reg [`PC_WIDTH - 1 : 0] out_pc_4,
    output reg [`REGS_WIDTH - 1 : 0] out_rd_address,
    output reg out_is_zero,
    output reg [`DATA_WIDTH - 1 : 0] out_ALU_result,
    output reg [`DATA_WIDTH - 1 : 0] out_rs2_data,
    output reg [`BRANCH_TYPE_WIDTH - 1 : 0] out_branch_type,
    output reg out_is_write_mem_future,
    output reg [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] out_mem_to_regs_option,
    output reg out_is_write_regs_future,

    output reg [`DATA_WIDTH - 1 : 0] out_immediate
);
    initial begin
        out_branch_pc = 0;
        out_pc = 0;
        out_pc_4 = 0;
        out_rd_address = 0;
        out_is_zero = 0;
        out_ALU_result = 0;
        out_rs2_data = 0;
        out_branch_type = 0;
        out_is_write_mem_future = 0;
        out_is_write_regs_future = 0;
        out_mem_to_regs_option = 0;

        out_immediate = 0;
        out_instruction = 0;
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out_branch_pc <= 0;
            out_pc <= 0;
            out_pc_4 <= 0;
            out_rd_address <= 0;
            out_is_zero <= 0;
            out_ALU_result <= 0;
            out_rs2_data <= 0;
            out_branch_type <= 0;
            out_is_write_mem_future <= 0;
            out_is_write_regs_future <= 0;
            out_mem_to_regs_option <= 0;

            out_immediate <= 0;
            out_instruction <= 0;
        end
        else if (cpu_en) begin
            out_branch_pc <= in_branch_pc;
            out_pc <= in_pc;
            out_pc_4 <= in_pc_4;
            out_rd_address <= in_rd_address;
            out_is_zero <= in_is_zero;
            out_ALU_result <= in_ALU_result;
            out_rs2_data <= in_rs2_data;
            out_branch_type <= in_branch_type;
            out_is_write_mem_future <= in_is_write_mem_future;
            out_is_write_regs_future <= in_is_write_regs_future;
            out_mem_to_regs_option <= in_mem_to_regs_option;

            out_immediate <= in_immediate;
            out_instruction <= in_instruction;
        end
    end

endmodule //EXE_reg_MEM