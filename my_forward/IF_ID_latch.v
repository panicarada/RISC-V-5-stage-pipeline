`include "define.v"
module IF_ID_latch (
    input[`INST_WIDTH - 1 : 0] IF_instruction,
    input[`PC_WIDTH - 1 : 0] IF_pc_4,

    input is_stall,

    input cpu_en,
    input clk,
    input rst, // reset

    output reg [`INST_WIDTH - 1 : 0] ID_instruction,
    output reg [`PC_WIDTH - 1 : 0] ID_pc_4
);

    initial begin
        ID_instruction = 0;
        ID_pc_4 = 0;
    end

    always @(posedge clk) begin
        if (rst) begin
            ID_instruction <= 0;
            ID_pc_4 <= 0;
        end
        else if (cpu_en & ~is_stall) begin
            ID_instruction <= IF_instruction;
            ID_pc_4 <= IF_pc_4;
        end
    end

endmodule //IF_ID_latch