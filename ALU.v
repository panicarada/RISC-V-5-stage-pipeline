`include "define.v"

module ALU (
    input[`ALU_OPTION_WIDTH - 1 : 0] ALU_option,
    input[`DATA_WIDTH - 1 : 0] A,
    input[`DATA_WIDTH - 1 : 0] B,

    output[`DATA_WIDTH - 1 : 0] result
);

    initial begin
        $display("hello world!");
    end

    assign result = (ALU_option == `ALU_ADD) ? A + B
                  : (ALU_option == `ALU_SUB) ? A - B
                  : (ALU_option == `ALU_AND) ? A & B
                  : (ALU_option == `ALU_OR)  ? A | B
                  :/*(ALU_option == `ALU_SLT)?*/ (A < B) ? 1 : 0; 

endmodule //ALU