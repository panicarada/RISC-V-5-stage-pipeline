`include "define.vh"

module stall_controller (
    input rst,

    // 当前指令的信息
    input is_use_rs1, // 是否用到了rs1
    input [`REGS_WIDTH - 1 : 0] rs1_address, 
    input is_use_rs2,
    input [`REGS_WIDTH - 1 : 0] rs2_address,
    input [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type,

    // 上条指令的信息
    input is_write_regs_ID_EXE, // 是否要写入寄存器
    input [`REGS_WIDTH - 1 : 0] rd_address_ID_EXE, // 写入寄存器地址
    input [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type_ID_EXE,

    // 上上条指令的信息
    input is_write_regs_EXE_MEM,
    input [`REGS_WIDTH - 1 : 0] rd_address_EXE_MEM,
    input [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type_EXE_MEM,

    // 输出
    output reg IF_en, // IF的使能
    output reg IF_ID_en, // IF_ID暂存器的使能
    output reg is_nop_IF_ID, // 是否要清空IF_ID的内容
    output reg is_nop_ID_EXE // 是否要清空ID_EXE
);


    always @(*) begin
        
        // control hazard
        if ()
    end


endmodule //stall_controller