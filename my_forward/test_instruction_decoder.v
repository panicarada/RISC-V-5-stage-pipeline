`include "instruction_decoder.v"

module test_instruction_decoder ();
    reg clk;
    reg rst;
    reg [`PC_WIDTH - 1 : 0] pc;
    reg [`INST_WIDTH - 1 : 0] instruction;
    reg is_write_regs;
    reg [`REGS_WIDTH - 1 : 0] write_address;
    reg [`DATA_WIDTH - 1 : 0] write_data;
    
    initial begin
        $dumpfile("run.vcd");
        $dumpvars(0, test_instruction_decoder);

        clk = 0;
        rst = 0;
        pc = 0;
        instruction = 0;
        #20
        instruction = 32'h00300193; // addi x3 x0 3
        #40
        instruction = 32'h0641A083; // lw x1 100(x3)
        #40
        instruction = 32'h06408113; // addi x2 x1 100
        #40
        instruction = 32'h00208133; // add x2 x1 x2
        #40
        instruction = 0;

        #100
        $finish;
    end
    wire is_stall;
    wire [`ALU_OPTION_WIDTH - 1 : 0] ALU_option;
    wire [`DATA_WIDTH - 1 : 0] ALU_A;
    wire [`DATA_WIDTH - 1 : 0] ALU_B;
    wire is_write_MEM_future;
    wire is_write_regs_future;
    

    instruction_decoder instruction_decoder(
        .clk(clk),
        .cpu_en(1'b1),
        .rst(rst),
        .pc(pc),

        .instruction(instruction),
        .is_write_regs(is_write_regs),
        .write_address(write_address),
        .write_data(write_data),
        .is_stall(is_stall),
        .ALU_A(ALU_A),
        .ALU_B(ALU_B),
        .ALU_option(ALU_option),
        .is_write_MEM_future(is_write_MEM_future),
        .is_write_regs_future(is_write_regs_future)
    );

    always begin
        #20
        clk <= ~clk;
    end

endmodule //test_instruction_decoder