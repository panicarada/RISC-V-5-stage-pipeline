`include "define.vh"

module IF_reg_ID (
    input clk,
    input cpu_en,
    input rst,

    // stall控制信号
    input is_nop_IF_ID,

    // from instruction fetch
    input [`PC_WIDTH - 1 : 0] in_pc,
    input [`INST_WIDTH - 1 : 0] in_instruction,

    // to instruction decoder
    output reg [`PC_WIDTH - 1 : 0] out_pc,
    output reg [`INST_WIDTH - 1 : 0] out_instruction    
);
    initial begin
        out_pc = 0;
        out_instruction = 0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out_pc <= 0;
            out_instruction <= 0;
        end
        else if (cpu_en) begin
            out_pc <= in_pc;
            out_instruction <= in_instruction;
        end
        else if (is_nop_IF_ID) begin
            // 插入nop
            out_pc <= 0;
            out_instruction <= `NOP;
        end
    end

endmodule //IF_reg_ID