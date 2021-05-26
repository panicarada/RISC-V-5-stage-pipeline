`include "define.v"


module execution (
    input [`DATA_WIDTH - 1 : 0] forward_DM_read, // 上一条指令在memory access读到的值
    input [`DATA_WIDTH - 1 : 0] ID_ALU_A, // 在ID中得到的ALU_A输入
    input [`DATA_WIDTH - 1 : 0] ID_ALU_B, // 在ID中得到的ALU_B输入

    input is_MEM_forward_ALU_A, // ALU真正A的输入是否要从memory access forward得到
    input is_MEM_forward_ALU_B,

    input [`ALU_OPTION_WIDTH - 1 : 0] ALU_option,

    output reg [`DATA_WIDTH - 1 : 0] ALU_result
);  

    wire [`DATA_WIDTH - 1 : 0] ALU_A; // ALU真正的A输入
    wire [`DATA_WIDTH - 1 : 0] ALU_B; // ALU真正的B输入
    assign ALU_A = is_MEM_forward_ALU_A ? forward_DM_read : ID_ALU_A;
    assign ALU_B = is_MEM_forward_ALU_B ? forward_DM_read : ID_ALU_B;
    
    // ALU计算是组合电路
    always @* begin
        case (ALU_option)
            `ALU_AND: ALU_result = ALU_A & ALU_B;
            `ALU_OR : ALU_result = ALU_A | ALU_B;
            `ALU_ADD: ALU_result = ALU_A + ALU_B;
            `ALU_SUB: ALU_result = ALU_A - ALU_B;
            `ALU_SLT: ALU_result = (ALU_B > ALU_A) ? 1 : 0;
            default:
                begin
                    $display("Unknown ALU option: %b", ALU_option);
                    ALU_result = 0;
                end
        endcase
    end

endmodule //execution