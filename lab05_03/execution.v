`include "define.vh"
module execution (
    input [`PC_WIDTH - 1 : 0] pc,
    input [`DATA_WIDTH - 1 : 0] immediate,
    input [`DATA_WIDTH - 1 : 0] rs1_data,
    input [`DATA_WIDTH - 1 : 0] rs2_data,
    
    input [`ALU_OPTION_WIDTH - 1 : 0] ALU_option,
    input [`ALU_B_OPTION_WIDTH - 1 : 0] ALU_B_option,

    output [`PC_WIDTH - 1 : 0] pc_4, // pc + 4
    output [`PC_WIDTH - 1 : 0] branch_pc, // pc + 立即数
    output [`DATA_WIDTH - 1 : 0] ALU_result,
    output is_zero // ALU结果，是否为0
);
    assign pc_4 = pc + 4;
    assign branch_pc = pc + immediate;
    reg [`DATA_WIDTH - 1 : 0] ALU_B;
    // 组合电路
    always @(*) begin
        case (ALU_B_option)
            `ALU_B_OPTION_REGS: ALU_B = rs2_data;
            `ALU_B_OPTION_IMM : ALU_B = immediate;
        endcase
    end


    ALU ALU (
        .A(rs1_data),
        .B(ALU_B),
        .result(ALU_result),
        .is_zero(is_zero)
    );

endmodule //execution

module ALU (
    input [`DATA_WIDTH - 1 : 0] A,
    input [`DATA_WIDTH - 1 : 0] B,
    input [`ALU_OPTION_WIDTH - 1 : 0] ALU_option,
    
    output reg [`DATA_WIDTH - 1 : 0] result,
    output is_zero // 结果是否为0
);

    // 组合电路
    always @(*) begin
        case (ALU_option)
            `ALU_OPTION_ADD: result = A + B;
            `ALU_OPTION_SUB: result = A - B;
            `ALU_OPTION_AND: result = A & B;
            `ALU_OPTION_OR : result = A | B;
            `ALU_OPTION_XOR: result = A ^ B;
            `ALU_OPTION_SLL: result = A << B[4 : 0];
            `ALU_OPTION_SRL: result = A >> B[4 : 0];
            `ALU_OPTION_SLT: result = (A < B) ? 1 : 0;
            default: result = 0;
        endcase
    end
    assign is_zero = (result == 0) ? 1'b1 : 1'b0;

endmodule