`include "define.v"

module ID_EXE_latch (
    input [`DATA_WIDTH - 1 : 0] ID_ALU_A,
    input [`DATA_WIDTH - 1 : 0] ID_ALU_B,
    input [`ALU_OPTION_WIDTH - 1 : 0] ID_ALU_option,
    input ID_is_write_MEM_future,
    input ID_is_write_regs_future,

    // from <top module>
    input cpu_en,
    input clk,
    input rst, // reset

    output reg [`DATA_WIDTH - 1 : 0] MEM_ALU_A,
    output reg [`DATA_WIDTH - 1 : 0] MEM_ALU_B,
    output reg [`ALU_OPTION_WIDTH - 1 : 0] MEM_ALU_option,
    output reg MEM_is_write_MEM_future,
    output reg MEM_is_write_regs_future
);

    initial begin
        MEM_ALU_A = 0;
        MEM_ALU_B = 0;
        MEM_ALU_option = 0;
        MEM_is_write_MEM_future = 0;
        MEM_is_write_regs_future = 0;
    end

    always @(posedge clk) begin
        if (rst) begin
            MEM_ALU_A <= 0;
            MEM_ALU_B <= 0;
            MEM_ALU_option <= 0;
            MEM_is_write_MEM_future <= 0;
            MEM_is_write_regs_future <= 0;
        end
        else if (cpu_en) begin
            MEM_ALU_A <= ID_ALU_A;
            MEM_ALU_B <= ID_ALU_B;
            MEM_ALU_option <= ID_ALU_option;
            MEM_is_write_MEM_future <= ID_is_write_MEM_future;
            MEM_is_write_regs_future <= ID_is_write_regs_future;
        end
    end

endmodule //ID_EXE_latch