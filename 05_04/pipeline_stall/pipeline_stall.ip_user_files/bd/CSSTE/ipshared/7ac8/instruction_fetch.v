`include "define.vh"
module instruction_fetch (
    input clk,
    input cpu_en, // 使能信号 
    input rst,

    // input is_branch, // 是否要跳�?
    input [`BRANCH_CONDITION_WIDTH - 1 : 0] branch_condition, // 跳转条件

    input [`PC_WIDTH - 1 : 0] branch_pc, // 跳转地址
    input [`PC_WIDTH - 1 : 0] pc_4_MEM, // memory access�?含指令对应pc + 4，当跳转指令失败时，�?要回到这�?

    output reg signed [`PC_WIDTH - 1 : 0] pc
);
    
    initial begin
        pc = 0;
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 0;
        end
        else if (cpu_en) begin
            if (branch_condition == `BRANCH_CONDITION_NONE) begin
                // 并非跳转指令
                pc <= pc + 4;
            end
            else if (branch_condition == `BRANCH_CONDITION_YES) begin
                // 跳转指令，并且跳�?
                pc <= branch_pc;
            end
            else if (branch_condition == `BRANCH_CONDITION_NO) begin
                // 跳转指令，但是不跳转
                pc <= pc_4_MEM;
            end
        end
    end

endmodule //instruction_fetch