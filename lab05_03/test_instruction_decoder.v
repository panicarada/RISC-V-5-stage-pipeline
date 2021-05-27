`include "instruction_decoder.v"

module test_instruction_decoder ();
    reg clk;
    reg rst;
    reg [`INST_WIDTH - 1 : 0] instruction;
    reg is_write_regs;
    reg [`REGS_WIDTH - 1 : 0] write_address;
    reg [`DATA_WIDTH - 1 : 0] write_data;

    initial begin
        $dumpfile("run.vcd");
        $dumpvars(0, test_instruction_decoder);

        clk = 0;
        rst = 0;
        instruction = 0;
        #20;
        instruction = 32'h000080B3; // add x1 x1 x0
        #40;
        instruction = 32'h003E8137; // lui x2 1000
        #40;
        instruction = 32'h3E8001EF; // jal x3 1000
        #40;
        instruction = 32'h064202E7; // jalr x5 x4 100
        #40;
        instruction = 32'h01E20213; // addi x4 x4 30
        #40;
        instruction = `NOP;
        #100;
        $finish;
    end
    
    wire [`REGS_WIDTH - 1 : 0] rd_address;
    wire [`DATA_WIDTH - 1 : 0] rs1_data;
    wire [`DATA_WIDTH - 1 : 0] rs2_data;
    wire [`DATA_WIDTH - 1 : 0] immediate;
    wire [`ALU_B_OPTION_WIDTH - 1 : 0] ALU_B_option;
    wire [`ALU_OPTION_WIDTH - 1 : 0] ALU_option;
    wire [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type;
    wire [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] mem_to_regs_option;

    wire is_write_mem_future;
    wire is_write_regs_future;

    instruction_decoder instruction_decoder(
        .clk(clk),
        .rst(rst),
        .cpu_en(1'b1),
        .instruction(instruction),
        .is_write_regs(1'b0),
        .write_regs_address(5'b0),
        .write_regs_data(0),
        .rd_address(rd_address),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .immediate(immediate),
        .ALU_B_option(ALU_B_option),
        .ALU_option(ALU_option),
        .branch_type(branch_type),
        .mem_to_regs_option(mem_to_regs_option),
        .is_write_mem_future(is_write_mem_future),
        .is_write_regs_future(is_write_regs_future)
    );


    always begin
        #20
        clk <= ~clk;
    end
endmodule //test_instruction_decoder