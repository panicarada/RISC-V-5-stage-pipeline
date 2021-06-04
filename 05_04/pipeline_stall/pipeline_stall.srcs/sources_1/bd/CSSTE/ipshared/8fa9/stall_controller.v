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

    reg is_data_stall; // 数据冲突引起的stall
    reg is_control_stall; // 结构冲突引起的stall

    always @(*) begin
        // mem data hazard
        if (is_write_regs_EXE_MEM & is_use_rs1 & rs1_address != 0 & rd_address_EXE_MEM == rs1_address) begin
            // 上上条指令要写入现在的rs1
            is_data_stall = 1;
        end
        else if (is_write_regs_EXE_MEM & is_use_rs2 & rs2_address != 0 & rd_address_EXE_MEM == rs2_address) begin
            // 上上条指令要写入现在的rs2
            is_data_stall = 1;
        end
        // exe data hazard
        else if (is_write_regs_ID_EXE & is_use_rs1 & rs1_address != 0 & rd_address_ID_EXE == rs1_address) begin
            // 上条指令要写入现在的rs1
            is_data_stall = 1;
        end
        else if (is_write_regs_ID_EXE & is_use_rs2 & rs2_address != 0 & rd_address_ID_EXE == rs2_address) begin
            // 上条指令要写入现在的rs2
            is_data_stall = 1;
        end
        else is_data_stall = 0;


        // control hazard
        if (branch_type != `BRANCH_TYPE_NONE) begin
            // ID当前指令是跳转
            is_control_stall = 1;
        end
        else if(branch_type_ID_EXE != `BRANCH_TYPE_NONE) begin
            // 上条指令是跳转
            is_control_stall = 1;
        end
        else if (branch_type_EXE_MEM != `BRANCH_TYPE_NONE) begin
            // 上上条指令是跳转
            is_control_stall = 1;
        end
        else is_control_stall = 0;

        
        if (is_data_stall) begin
        // data hazard
            IF_en = 0; // PC不再自增，假设当前ID的指令为pc = x，那么就把pc锁在x + 4
            IF_ID_en = 0; // IF_ID寄存器不再更新输出指令，即保留了x对应的指令
            is_nop_ID_EXE = 1; // 要避免当前ID的指令x往后传播，所以在ID_EXE寄存器插入NOP

            is_nop_IF_ID = 0;
        end
        else if (is_control_stall) begin
        // control hazard
            IF_en = 1; // PC自增无所谓，总是会插入NOP
            IF_ID_en = 0;
            is_nop_IF_ID = 1; // branch指令只会被处理一次
            // branch指令还是正常向右流动
            is_nop_ID_EXE = 0;
        end
        else begin
            // 一切正常
            IF_en = 1;
            IF_ID_en = 1;
            is_nop_IF_ID = 0;
            is_nop_ID_EXE = 0;
        end

        // if (is_control_stall) begin
        //     // branch指令要向后传播
        //     // 但是只能够处理一次
        //     is_nop_IF_ID = 1;
        //     // TODO: 一定是有问题的，只是把后续pc自增读进来的指令全部清空了
        //     // TODO: 但是如果不跳转，这些指令就丢了，没有机会回到x + 4的指令（假设第一条跳转指令对应pc为x）
        // end
        // else begin
        //     // 一切正常 
        //     is_nop_IF_ID = 0;
        // end
    end


endmodule //stall_controller