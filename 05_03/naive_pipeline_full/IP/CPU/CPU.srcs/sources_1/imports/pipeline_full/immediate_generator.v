`include "define.vh"


// 根据指令产生立即数
module immediate_generator (
    input [`INST_WIDTH - 1 : 0] instruction,
    input [`INST_TYPE_WIDTH - 1 : 0] instruction_type,
    output reg signed [`DATA_WIDTH - 1 : 0] immediate
);

    always @(*) begin
        case (instruction_type) 
            `INST_TYPE_I: begin
                // immediate = {20'b0, instruction[31 : 31-11]};
                immediate = $signed({instruction[31 : 31-11]});
            end
            `INST_TYPE_S: begin
                // immediate = {20'b0, instruction[31 : 31-6], instruction[7+4 : 7]};
                immediate = $signed({instruction[31 : 31-6], instruction[7+4 : 7]});
            end
            `INST_TYPE_SB: begin
                // immediate = {19'b0, instruction[31], instruction[7], 
                //              instruction[30 : 30-5], instruction[8+3 : 8], 1'b0};
                immediate = $signed({instruction[31], instruction[7], 
                             instruction[30 : 30-5], instruction[8+3 : 8], 1'b0});

                // immediate[12] = instruction[31];
                // immediate[10:5] = instruction[30 : 30-5];
                // immediate[4:1] = instruction[8+3 : 8];
                // immediate[11] = instruction[7];
                // immediate[0] = 0;
            end
            `INST_TYPE_U: begin
                immediate = $signed({instruction[31 : 31-19], 12'b0});
            end
            `INST_TYPE_JAL: begin
                // immediate = {11'b0, instruction[31], instruction[12+7 : 12], 
                            //  instruction[30-10], instruction[30 : 30-9], 1'b0};
                immediate = $signed({instruction[31], instruction[12+7 : 12], 
                             instruction[30-10], instruction[30 : 30-9], 1'b0});
                // immediate[20] = instruction[31];
                // immediate[10:1] = instruction[30 : 30-9];
                // immediate[11] = instruction[30-10];
                // immediate[19:12] = instruction[12+7 : 12];
            end
            `INST_TYPE_JALR: begin
                immediate = $signed({instruction[31 : 31 - 19], 12'b0});
            end
        endcase
    end

endmodule //immediate_generator