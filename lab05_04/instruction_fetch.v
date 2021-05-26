`include "define.vh"
module instruction_fetch (
    input clk,
    input cpu_en, // 使能信号 
    input rst,

    input is_branch, // 是否要跳转
    input [`PC_WIDTH - 1 : 0] branch_pc, // 跳转地址

    output reg [`PC_WIDTH - 1 : 0] pc
);

    initial begin
        pc = 0;
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 0;
        end
        else if (cpu_en) begin
            pc <= (is_branch) ? (branch_pc) : pc + 4;
        end
    end

endmodule //instruction_fetch