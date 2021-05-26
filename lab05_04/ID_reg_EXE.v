`include "define.vh"

module ID_reg_EXE (
    input clk,
    input cpu_en,
    input rst,

    input [`PC_WIDTH - 1 : 0] in_pc,
    input [`REGS_WIDTH - 1 : 0] in_rd_address,
    input [`DATA_WIDTH - 1 : 0] in_rs1_data,
    input [`DATA_WIDTH - 1 : 0] in_rs2_data,
    input [`DATA_WIDTH - 1 : 0] in_immediate,
    input [`ALU_B_OPTION_WIDTH - 1 : 0] in_ALU_B_option,
    input [`ALU_OPTION_WIDTH - 1 : 0] in_ALU_option,
    input [`BRANCH_TYPE_WIDTH - 1 : 0] in_branch_type,
    input in_is_write_mem_future,
    input [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] in_mem_to_regs_option,
    input in_is_write_regs_future,

    output reg [`PC_WIDTH - 1 : 0] out_pc,
    output reg [`REGS_WIDTH - 1 : 0] out_rd_address,
    output reg [`DATA_WIDTH - 1 : 0] out_rs1_data,
    output reg [`DATA_WIDTH - 1 : 0] out_rs2_data,
    output reg [`DATA_WIDTH - 1 : 0] out_immediate,
    output reg [`ALU_B_OPTION_WIDTH - 1 : 0] out_ALU_B_option,
    output reg [`ALU_OPTION_WIDTH - 1 : 0] out_ALU_option,
    output reg [`BRANCH_TYPE_WIDTH - 1 : 0] out_branch_type,
    output reg out_is_write_mem_future,
    output reg [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] out_mem_to_regs_option,
    output reg out_is_write_regs_future  //
);  
    initial begin
        out_pc = 0;
        out_rd_address = 0;
        out_rs1_data = 0;
        out_rs2_data = 0;
        out_immediate = 0;
        out_ALU_B_option = 0;
        out_ALU_option = 0;
        out_branch_type = 0;
        out_is_write_mem_future = 0;
        out_is_write_regs_future = 0;
        out_mem_to_regs_option = 0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out_pc <= 0;
            out_rd_address <= 0;
            out_rs1_data <= 0;
            out_rs2_data <= 0;
            out_immediate <= 0;
            out_ALU_B_option <= 0;
            out_ALU_option <= 0;
            out_branch_type <= 0;
            out_is_write_mem_future <= 0;
            out_is_write_regs_future <= 0;
            out_mem_to_regs_option <= 0;
        end
        else if (cpu_en) begin
            out_pc <= in_pc;
            out_rd_address <= in_rd_address;
            out_rs1_data <= in_rs1_data;
            out_rs2_data <= in_rs2_data;
            out_immediate <= in_immediate;
            out_ALU_B_option <= in_ALU_B_option;
            out_ALU_option <= in_ALU_option;
            out_branch_type <= in_branch_type;
            out_is_write_mem_future <= in_is_write_mem_future;
            out_is_write_regs_future <= in_is_write_regs_future;
            out_mem_to_regs_option <= in_mem_to_regs_option;
        end
    end


endmodule //ID_reg_EXE