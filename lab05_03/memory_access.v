`include "define.vh"

module memory_access (
    input [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type,
    input ALU_is_zero, // ALU结果是否为0

    output reg is_branch // 是否要跳转
);

    always @(*) begin
        if (branch_type == `BRANCH_TYPE_JAL
          | (branch_type == `BRANCH_TYPE_BEQ &  ALU_is_zero)
          | (branch_type == `BRANCH_TYPE_BNE & ~ALU_is_zero)) begin
              // 需要跳转
              is_branch = 1;
          end
        else begin
            is_branch = 0;
        end
    end

endmodule //memory_access