
`include "define.vh"

module VGA (
    input wire clk_25m,
    input wire clk_100m,
    input wire rst,
    
    input wire [31:0] pc_IF,
    input wire [31:0] inst_IF,
    input wire [31:0] pc_ID,
    input wire [31:0] inst_ID,
    input wire [31:0] pc_EXE,
    input wire MemRW_Ex,
    input wire MemRW_Mem,
    input wire [31:0] write_mem_data, // 替换掉Data_out，要写入内存的数据
    input wire [31:0] ALU_result_MEM, // 替换掉Addr_out，MEM中储存的ALU运算结果

    /* 自定义 */
    input [`REGS_WIDTH - 1 : 0] rd_address_EXE,
    input [`REGS_WIDTH - 1 : 0] rs1_address_EXE,
    input [`REGS_WIDTH - 1 : 0] rs2_address_EXE,
    input [`DATA_WIDTH - 1 : 0] rs1_data_EXE,
    input [`DATA_WIDTH - 1 : 0] rs2_data_EXE,
    input is_write_regs_future_EXE,
    input is_B_immediate_EXE,
    input [`PC_WIDTH - 1 : 0] instruction_EXE,
    input [`DATA_WIDTH - 1 : 0] immediate_EXE,
    input is_branch_EXE,
    input is_jal_EXE,
    input is_jalr_EXE,
    input is_lui_EXE,
    input [`ALU_OPTION_WIDTH - 1 : 0] ALU_option_EXE,

    input [`PC_WIDTH - 1 : 0] pc_MEM,
    input [`INST_WIDTH - 1 : 0] instruction_MEM,
    input [`REGS_WIDTH - 1 : 0] rd_address_MEM,
    input is_write_regs_future_MEM,
    input is_jal_MEM,
    input is_jalr_MEM,
    input [`PC_WIDTH - 1 : 0] pc_WB,
    input [`INST_WIDTH - 1 : 0] instruction_WB,
    input [`REGS_WIDTH - 1 : 0] rd_address_WB,
    input is_write_regs,
    input [`DATA_WIDTH - 1 : 0] write_regs_data, // 替换掉Data_out_WB

    input [(`REGS_NUM - 1) * `DATA_WIDTH - 1 : 0] flatten_registers, // 所有寄存器的数据展开成一维

    // input wire [31:0] Data_out_WB,
    output wire hs,
    output wire vs,
    output wire [3:0] vga_r,
    output wire [3:0] vga_g,
    output wire [3:0] vga_b
);


    wire [9:0] vga_x;
    wire [8:0] vga_y;
    wire video_on;
    VgaController vga_controller(
        .clk(clk_25m),
        .rst(rst),
        .vga_x(vga_x),
        .vga_y(vga_y),
        .hs(hs),
        .vs(vs),
        .video_on(video_on)
    );

    wire display_wen;
    wire [11:0] display_w_addr;
    wire [7:0] display_w_data;
    VgaDisplay vga_display(
        .clk(clk_100m),
        .video_on(video_on),
        .vga_x(vga_x),
        .vga_y(vga_y),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b),
        .wen(display_wen),
        .w_addr(display_w_addr),
        .w_data(display_w_data)
    );


    // 把一维寄存器数据展开成32个数据
    reg [`DATA_WIDTH - 1 : 0] registers [1 : `REGS_NUM - 1];
    integer i;
    always @(*) begin
        for (i = 1; i < `REGS_NUM; i = i + 1) begin
            // flatten_registers[i] = registers[i * `DATA_WIDTH - 1 : (i - 1) * (`DATA_WIDTH)];
            // 的有效写法
            registers[i] = flatten_registers[i * `DATA_WIDTH - 1 -: `DATA_WIDTH];
        end
    end

    VgaDebugger vga_debugger(
        // DEBUG
        .pc(pc_IF),
        .inst(inst_IF),
        .IfId_pc(pc_ID),
        .IfId_inst(inst_ID),
        .IfId_valid(),
        .IdEx_pc(pc_EXE),
        .IdEx_inst(instruction_EXE),
        .IdEx_valid(),
        .IdEx_rd(rd_address_EXE),
        .IdEx_rs1(rs1_address_EXE),
        .IdEx_rs2(rs2_address_EXE),
        .IdEx_rs1_val(rs1_data_EXE),
        .IdEx_rs2_val(rs2_data_EXE),
        .IdEx_reg_wen(is_write_regs_future_EXE),
        .IdEx_is_imm(is_write_regs_future_EXE),
        .IdEx_imm(immediate_EXE),
        .IdEx_mem_wen(MemRW_Ex),
        .IdEx_mem_ren(),
        .IdEx_is_branch(is_branch_EXE),
        .IdEx_is_jal(is_jal_EXE),
        .IdEx_is_jalr(is_jalr_EXE),
        .IdEx_is_auipc(),
        .IdEx_is_lui(is_lui_EXE),
        .IdEx_alu_ctrl(ALU_option_EXE),
        .IdEx_cmp_ctrl(),
        .ExMa_pc(pc_MEM),
        .ExMa_inst(instruction_MEM),
        .ExMa_valid(),
        .ExMa_rd(rd_address_MEM),
        .ExMa_reg_wen(is_write_regs_future_MEM),
        .ExMa_mem_w_data(write_mem_data),
        .ExMa_alu_res(ALU_result_MEM),
        .ExMa_mem_wen(MemRW_Mem),
        .ExMa_mem_ren(),
        .ExMa_is_jal(is_jal_MEM),
        .ExMa_is_jalr(is_jalr_MEM),
        .MaWb_pc(pc_WB),
        .MaWb_inst(instruction_WB),
        .MaWb_valid(),
        .MaWb_rd(rd_address_WB),
        .MaWb_reg_wen(is_write_regs),
        .MaWb_reg_w_data(write_regs_data),
        .x0(),
        .ra(registers[1]),
        .sp(registers[2]),
        .gp(registers[3]),
        .tp(registers[4]),
        .t0(registers[5]),
        .t1(registers[6]),
        .t2(registers[7]),
        .s0(registers[8]),
        .s1(registers[9]),
        .a0(registers[10]),
        .a1(registers[11]),
        .a2(registers[12]),
        .a3(registers[13]),
        .a4(registers[14]),
        .a5(registers[15]),
        .a6(registers[16]),
        .a7(registers[17]),
        .s2(registers[18]),
        .s3(registers[19]),
        .s4(registers[20]),
        .s5(registers[21]),
        .s6(registers[22]),
        .s7(registers[23]),
        .s8(registers[24]),
        .s9(registers[25]),
        .s10(registers[26]),
        .s11(registers[27]),
        .t3(registers[28]),
        .t4(registers[29]),
        .t5(registers[30]),
        .t6(registers[31]), 
        .clk(clk_100m),
        .display_wen(display_wen),
        .display_w_addr(display_w_addr),
        .display_w_data(display_w_data)
    );


    
endmodule