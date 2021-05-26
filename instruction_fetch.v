`include "define.v"


module instruction_fetch(
    input is_branch, // 是否需要跳转
    input[`PC_WIDTH - 1 : 0] branch_pc,
    input is_restore, // 如果刚才跳转失误，需要重新返回正确的pc值

    input is_stall,

    // from <top module>
    input cpu_en,
    input clk,
    input rst, // reset

    output reg [`PC_WIDTH - 1 : 0] pc
);
    reg[`PC_WIDTH - 1 : 0] restore_addr; // 如果采用predicted jump的策略，预测失败时需要恢复的pc值

    initial begin
        restore_addr = 0;
        pc = 0;
    end

    always @(posedge clk) begin
        if (rst) pc <= 0;
        else if (cpu_en & ~is_stall) begin
            if (is_branch) begin
                pc <= branch_pc;
                restore_addr <= pc + 4;
            end 
            else if (is_restore) pc <= restore_addr;
            else pc <= pc + 4;
        end
    end

endmodule