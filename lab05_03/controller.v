`include "define.vh"

module controller (
    input [`OP_WIDTH - 1 : 0] opcode,
    input [2 : 0] funct3,
    input funct7, // instruction[30]

    output reg [`INST_TYPE_WIDTH - 1 : 0] instruction_type,
    output reg [`ALU_B_OPTION_WIDTH - 1 : 0] ALU_B_option, // ALU B输入的选择信号
    output reg [`ALU_OPTION_WIDTH - 1 : 0] ALU_option, // ALU操作选项

    output reg [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type, // 跳转类型

    output reg is_write_mem_future, // 是否要写入DM
    output reg is_write_regs_future // 是否要写入寄存器
);

    always @(*) begin
        case (opcode)   
            `OP_R_TYPE: begin
                instruction_type = `INST_TYPE_R;
                ALU_B_option = `ALU_B_OPTION_REGS;
                branch_type = `BRANCH_TYPE_NONE;
                is_write_mem_future = 0;
                is_write_regs_future = 1;
                case ({funct3, funct7}) 
                    `FUNCT_ADD: ALU_option = `ALU_OPTION_ADD;
                    `FUNCT_SUB: ALU_option = `ALU_OPTION_SUB;
                    `FUNCT_SLL: ALU_option = `ALU_OPTION_SLL;
                    `FUNCT_SRL: ALU_option = `ALU_OPTION_SRL;
                    `FUNCT_AND: ALU_option = `ALU_OPTION_AND;
                    `FUNCT_OR : ALU_option = `ALU_OPTION_OR;
                    `FUNCT_XOR: ALU_option = `ALU_OPTION_XOR;
                    default: $display("Unsupported funct: %b", {funct3, funct7});
                endcase
            end
            `OP_LOAD: begin
                instruction_type = `INST_TYPE_I;
                ALU_B_option = `ALU_B_OPTION_IMM;
                branch_type = `BRANCH_TYPE_NONE;
                is_write_mem_future = 0;
                is_write_regs_future = 1;
                ALU_option = `ALU_OPTION_ADD; // rs1的数据 + 立即数
                case (funct3)
                    `FUNCT3_LW: $display("lw指令");
                endcase
            end
            `OP_I_ARITHMETIC: begin
                instruction_type = `INST_TYPE_I;
                ALU_B_option = `ALU_B_OPTION_IMM;
                branch_type = `BRANCH_TYPE_NONE;
                is_write_mem_future = 0;
                is_write_regs_future = 1;
                case ({funct3, funct7}) 
                    `FUNCT3_ADDI: ALU_option = `ALU_OPTION_ADD;
                    `FUNCT3_SLLI: ALU_option = `ALU_OPTION_SLL;
                    `FUNCT3_XORI: ALU_option = `ALU_OPTION_XOR;
                    `FUNCT3_ANDI: ALU_option = `ALU_OPTION_AND;
                    `FUNCT3_ORI: ALU_option = `ALU_OPTION_OR;
                    default: $display("Unsupported funct3: %b", funct3);
                endcase 
            end
            `OP_S_TYPE: begin
                instruction_type = `INST_TYPE_S;
                ALU_B_option = `ALU_B_OPTION_IMM;
                branch_type = `BRANCH_TYPE_NONE;
                is_write_mem_future = 1;
                is_write_regs_future = 0;
                ALU_option = `ALU_OPTION_ADD; // rs1的数据 + 立即数 = 内存写入地址
            end
        endcase
    end

endmodule //controller