`include "define.vh"

module memory_access (
    input [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type,
    input ALU_is_zero, // ALU结果是否为0

    // output reg is_branch // 是否要跳转
    output reg [`BRANCH_CONDITION_WIDTH - 1 : 0] branch_condition // 跳转条件
);

    always @(*) begin
        case (branch_type)
            `BRANCH_TYPE_NONE: branch_condition = `BRANCH_CONDITION_NONE;
            `BRANCH_TYPE_JAL: branch_condition = `BRANCH_CONDITION_YES; // 无条件跳转
            `BRANCH_TYPE_JALR: branch_condition = `BRANCH_CONDITION_YES; // 无条件跳转
            `BRANCH_TYPE_BEQ: branch_condition = (ALU_is_zero) ? `BRANCH_CONDITION_YES : `BRANCH_CONDITION_NO;
            `BRANCH_TYPE_BNE: branch_condition = (~ALU_is_zero) ? `BRANCH_CONDITION_YES : `BRANCH_CONDITION_NO;
        endcase
    end

endmodule //memory_access