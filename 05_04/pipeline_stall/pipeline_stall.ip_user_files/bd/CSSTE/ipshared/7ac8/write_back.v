`include "define.vh"

module write_back (
    input [`PC_WIDTH - 1 : 0] pc_4,
    input [`DATA_WIDTH - 1 : 0] ALU_result,
    input [`DATA_WIDTH - 1 : 0] mem_read_data, // memory读出的数据
    input [`DATA_WIDTH - 1 : 0] immediate,

    input [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] mem_to_regs_option, // memory写入instruction decoder的选项

    output reg [`DATA_WIDTH - 1 : 0] write_data // 写入instruction decoder寄存器的数据
);

    always @(*) begin
        case (mem_to_regs_option)
            `MEM_TO_REGS_OPTION_ALU: write_data = ALU_result;
            `MEM_TO_REGS_OPTION_MEM_READ: write_data = mem_read_data;
            `MEM_TO_REGS_OPTION_PC_4: write_data = pc_4;
            `MEM_TO_REGS_OPTION_IMM: write_data = immediate;
        endcase
    end

endmodule //write_back