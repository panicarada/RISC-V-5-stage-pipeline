`include "instruction_fetch.v"
`include "IF_reg_ID.v"
`include "instruction_decoder.v"
`include "ID_reg_EXE.v"
`include "execution.v"
`include "EXE_reg_MEM.v"
`include "memory_access.v"
`include "MEM_reg_WB.v"
`include "write_back.v"

module pipeline_CPU (
    input clk,
    input rst,

    input [`INST_WIDTH - 1 : 0] instruction_IF, // ROM璇诲彇鍑虹殑鎸囦护
    input [`DATA_WIDTH - 1 : 0] mem_read_data_MEM, // 璇诲彇DM鐨勫??

    output [`PC_WIDTH - 1 : 0] pc_IF, // IF涓殑pc鍊?
    output [`PC_WIDTH - 1 : 0] pc_ID,
    output [`INST_WIDTH - 1 : 0] instruction_ID, // ID澶勭悊鐨勬寚浠?
    output [`PC_WIDTH - 1 : 0] pc_EXE,
    output is_write_mem_future_EXE,
    output is_write_mem_future_MEM,
    output [`INST_WIDTH - 1 : 0] instruction_EXE,
    output [`DATA_WIDTH - 1 : 0] write_mem_data,
    output [`DATA_WIDTH - 1 : 0] ALU_result_MEM,
    
    output [`REGS_WIDTH - 1 : 0] rs1_address_ID,
    output [`REGS_WIDTH - 1 : 0] rs2_address_ID,
    
    output [`REGS_WIDTH - 1 : 0] rd_address_EXE,
    output [`REGS_WIDTH - 1 : 0] rs1_address_EXE,
    output [`REGS_WIDTH - 1 : 0] rs2_address_EXE,
    output [`DATA_WIDTH - 1 : 0] rs1_data_EXE,
    output [`DATA_WIDTH - 1 : 0] rs2_data_EXE,
    output is_write_regs_future_EXE,
    output is_B_immediate_EXE,
    output [`DATA_WIDTH - 1 : 0] immediate_EXE,
    output is_branch_EXE,
    output is_jal_EXE,
    output is_jalr_EXE,
    output is_lui_EXE,
    output [`ALU_OPTION_WIDTH - 1 : 0] ALU_option_EXE,
    output [`PC_WIDTH - 1 : 0] pc_MEM,
    output [`INST_WIDTH - 1 : 0] instruction_MEM,
    output is_write_regs_future_MEM,
    output is_jal_MEM,
    output is_jalr_MEM,
    output [`PC_WIDTH - 1 : 0] pc_WB,
    output [`REGS_WIDTH - 1 : 0] rd_address_WB,
    output is_write_regs,
    output [`DATA_WIDTH - 1 : 0] write_regs_data,
    output [(`REGS_NUM - 1) * `DATA_WIDTH - 1 : 0] flatten_registers,

    output [`INST_WIDTH - 1 : 0] instruction_WB,
    output [`REGS_WIDTH - 1 : 0] rd_address_MEM
);
    // 你知道吗？
    // 可恶的clk_cpu会！！！！偷！！！！跳7次
    // always！！！！
    // WTF?????!!!!
    // 为什么是这样？？？
    // I don't know
    // what the hell is going on ?
    // goddamn anti jitter模块一定有问题
    // 什么问题？
    // I don't know
    // anyway, 7次
    // 永远，永远偷跑7次！！！！！
    // 7次！！！浪费我多少时间？？
    // 7次！！！！
    integer goddamn_seven_counter;
    initial begin
        // 7次！！！！
        goddamn_seven_counter = 7;
    end
    always @(posedge clk or posedge rst) begin
        if (rst) goddamn_seven_counter = 7;
        else if (goddamn_seven_counter > 0)
            goddamn_seven_counter <= goddamn_seven_counter - 1;
    end
    wire clk_cpu_real; // real cpu clk
    // hacking: omit the first 7 clock cycles
    assign clk_cpu_real = (goddamn_seven_counter > 0) ? 1'b0 : clk;


    // wire [`PC_WIDTH  - 1 : 0] pc_IF;
    wire [`BRANCH_CONDITION_WIDTH - 1 : 0] branch_condition_IF;
    wire [`PC_WIDTH - 1 : 0] branch_pc_IF;
    wire IF_en; // IF鐨勪娇鑳?

    wire [`PC_WIDTH - 1 : 0] pc_4_MEM;

    instruction_fetch instruction_fetch(
        .clk(clk_cpu_real),
        .cpu_en(IF_en),
        .rst(rst),
        .branch_condition(branch_condition_IF),
        .branch_pc(branch_pc_IF),
        .pc_4_MEM(pc_4_MEM),

        .pc(pc_IF)
    );

    // wire [`PC_WIDTH - 1 : 0] pc_ID;
    // wire [`INST_WIDTH - 1 : 0] instruction_ID;
    wire IF_ID_en; // IF_ID latch鐨勪娇鑳?
    wire is_nop_IF_ID; // 鏄惁鎻掑叆nop
    IF_reg_ID IF_reg_ID(
        .clk(clk_cpu_real),
        .cpu_en(IF_ID_en),
        .rst(rst),
        .in_pc(pc_IF),
        .in_instruction(instruction_IF),
        
        .out_pc(pc_ID),
        .out_instruction(instruction_ID),

        .is_nop_IF_ID(is_nop_IF_ID)
    );

    // wire is_write_regs;
    wire [`REGS_WIDTH - 1 : 0] write_regs_address;
    // wire [`DATA_WIDTH - 1 : 0] write_regs_data;
    wire [`REGS_WIDTH - 1 : 0] rd_address_ID;
    wire [`DATA_WIDTH - 1 : 0] rs1_data_ID;
    wire [`DATA_WIDTH - 1 : 0] rs2_data_ID;
    wire [`DATA_WIDTH - 1 : 0] immediate_ID;
    wire [`ALU_B_OPTION_WIDTH - 1 : 0] ALU_B_option_ID;
    wire [`ALU_OPTION_WIDTH - 1 : 0] ALU_option_ID;
    wire [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type_ID;
    wire [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] mem_to_regs_option_ID;
    wire is_write_mem_future_ID;
    wire is_write_regs_future_ID;


    /* stall浣跨敤 */
    wire is_write_regs_ID_EXE;
    wire [`REGS_WIDTH - 1 : 0] rd_address_ID_EXE;
    wire [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type_ID_EXE;
    wire is_write_regs_EXE_MEM;
    wire [`REGS_WIDTH - 1 : 0] rd_address_EXE_MEM;
    wire [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type_EXE_MEM;

    wire is_nop_ID_EXE; // 鏄惁瑕佸湪ID_EXE鎻掑叆nop
    instruction_decoder instruction_decoder(
        .clk(clk_cpu_real),
        .rst(rst),
        .cpu_en(1'b1),
        .instruction(instruction_ID),
        .is_write_regs(is_write_regs),
        .write_regs_address(write_regs_address),
        .write_regs_data(write_regs_data),
        .rd_address(rd_address_ID),
        .rs1_data(rs1_data_ID),
        .rs2_data(rs2_data_ID),
        .immediate(immediate_ID),
        .ALU_B_option(ALU_B_option_ID),
        .ALU_option(ALU_option_ID),
        .branch_type(branch_type_ID),
        .mem_to_regs_option(mem_to_regs_option_ID),
        
        .is_write_mem_future(is_write_mem_future_ID),
        .is_write_regs_future(is_write_regs_future_ID),

        .rs1_address(rs1_address_ID),
        .rs2_address(rs2_address_ID),
        
        /* stall浣跨敤 */
        .is_write_regs_ID_EXE(is_write_regs_ID_EXE),
        .rd_address_ID_EXE(rd_address_ID_EXE),
        .branch_type_ID_EXE(branch_type_ID_EXE),

        .is_write_regs_EXE_MEM(is_write_regs_EXE_MEM),
        .rd_address_EXE_MEM(rd_address_EXE_MEM),
        .branch_type_EXE_MEM(branch_type_EXE_MEM),
        

        .IF_en(IF_en),
        .IF_ID_en(IF_ID_en),
        .is_nop_IF_ID(is_nop_IF_ID),
        .is_nop_ID_EXE(is_nop_ID_EXE),

        .flatten_registers(flatten_registers)
    );    

    // wire [`PC_WIDTH - 1 : 0] pc_EXE;
    // wire [`REGS_WIDTH - 1 : 0] rd_address_EXE;
    // wire [`DATA_WIDTH - 1 : 0] rs1_data_EXE;
    // wire [`DATA_WIDTH - 1 : 0] rs2_data_EXE;
    // wire [`DATA_WIDTH - 1 : 0] immediate_EXE;
    // wire [`ALU_B_OPTION_WIDTH - 1 : 0] ALU_B_option_EXE;
    // wire [`ALU_OPTION_WIDTH - 1 : 0] ALU_option_EXE;
     wire [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type_EXE;
    // wire is_write_mem_future_EXE;
    wire [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] mem_to_regs_option_EXE;
    // wire is_write_regs_future_EXE;
    ID_reg_EXE ID_reg_EXE(
        .clk(clk_cpu_real),
        .cpu_en(1'b1),
        .rst(rst),
        .in_pc(pc_ID),
        .in_rd_address(rd_address_ID),
        .in_rs1_data(rs1_data_ID),
        .in_rs2_data(rs2_data_ID),
        .in_immediate(immediate_ID),
        .in_ALU_B_option(ALU_B_option_ID),
        .in_ALU_option(ALU_option_ID),
        .in_branch_type(branch_type_ID),
        .in_is_write_mem_future(is_write_mem_future_ID),
        .in_mem_to_regs_option(mem_to_regs_option_ID),
        .in_is_write_regs_future(is_write_regs_future_ID),

        .in_rs1_address(rs1_address_ID),
        .in_rs2_address(rs2_address_ID),

        .in_instruction(instruction_ID),
        
        .out_instruction(instruction_EXE),

        .out_rs1_address(rs1_address_EXE),
        .out_rs2_address(rs2_address_EXE),

        .out_pc(pc_EXE),
        .out_rd_address(rd_address_EXE),
        .out_rs1_data(rs1_data_EXE),
        .out_rs2_data(rs2_data_EXE),
        .out_immediate(immediate_EXE),
        .out_ALU_B_option(ALU_B_option_EXE),
        .out_ALU_option(ALU_option_EXE),
        .out_branch_type(branch_type_EXE),
        .out_is_write_mem_future(is_write_mem_future_EXE),
        .out_mem_to_regs_option(mem_to_regs_option_EXE),
        .out_is_write_regs_future(is_write_regs_future_EXE),

        /* stall浣跨敤 */
        .is_nop_ID_EXE(is_nop_ID_EXE)
    );


    wire [`PC_WIDTH - 1 : 0] pc_4_EXE;
    wire [`PC_WIDTH - 1 : 0] branch_pc_EXE;
    wire [`DATA_WIDTH - 1 : 0] ALU_result_EXE;
    wire is_zero_EXE;
    execution execution(
        .pc(pc_EXE),
        .immediate(immediate_EXE),
        .rs1_data(rs1_data_EXE),
        .rs2_data(rs2_data_EXE),
        .ALU_option(ALU_option_EXE),
        .ALU_B_option(ALU_B_option_EXE),

        .pc_4(pc_4_EXE),
        .branch_pc(branch_pc_EXE),
        .ALU_result(ALU_result_EXE),
        .is_zero(is_zero_EXE),

        .branch_type(branch_type_EXE)
    );

    

    wire [`PC_WIDTH - 1 : 0] branch_pc_MEM;
    // wire [`REGS_WIDTH - 1 : 0] rd_address_MEM;
    wire is_zero_MEM;
    // wire [`DATA_WIDTH - 1 : 0] ALU_result_MEM;
    wire [`DATA_WIDTH - 1 : 0] rs2_data_MEM;
    wire [`BRANCH_TYPE_WIDTH - 1 : 0] branch_type_MEM;
    // wire is_write_mem_future_MEM;
    wire [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] mem_to_regs_option_MEM;
    // wire is_write_regs_future_MEM;
    wire [`DATA_WIDTH - 1 : 0] immediate_MEM;
    EXE_reg_MEM EXE_reg_MEM(
        .clk(clk_cpu_real),
        .cpu_en(1'b1),
        .rst(rst),
        .in_branch_pc(branch_pc_EXE),
        .in_pc_4(pc_4_EXE),
        .in_rd_address(rd_address_EXE),
        .in_is_zero(is_zero_EXE),
        .in_ALU_result(ALU_result_EXE),
        .in_rs2_data(rs2_data_EXE),
        .in_branch_type(branch_type_EXE),
        .in_is_write_mem_future(is_write_mem_future_EXE),
        .in_mem_to_regs_option(mem_to_regs_option_EXE),
        .in_is_write_regs_future(is_write_regs_future_EXE),
        .in_immediate(immediate_EXE),
        .in_pc(pc_EXE),

        .in_instruction(instruction_EXE),

        .out_instruction(instruction_MEM),

        .out_pc(pc_MEM),
        .out_branch_pc(branch_pc_MEM),
        .out_pc_4(pc_4_MEM),
        .out_rd_address(rd_address_MEM),
        .out_is_zero(is_zero_MEM),
        .out_ALU_result(ALU_result_MEM),
        .out_rs2_data(rs2_data_MEM),
        .out_branch_type(branch_type_MEM),
        .out_is_write_mem_future(is_write_mem_future_MEM),
        .out_mem_to_regs_option(mem_to_regs_option_MEM),
        .out_is_write_regs_future(is_write_regs_future_MEM),
        .out_immediate(immediate_MEM)
    );

    // MEM鍑烘潵鐨刡ranch浣嶇疆鎷夊洖缁橧F
    assign branch_pc_IF = branch_pc_MEM;


    wire [`BRANCH_CONDITION_WIDTH - 1 : 0] branch_condition_MEM;
    memory_access memory_access(
        .branch_type(branch_type_MEM),
        .ALU_is_zero(is_zero_MEM),
        
        .branch_condition(branch_condition_MEM)
    );

    assign branch_condition_IF = branch_condition_MEM;

    // TODO: data memory
    // wire [`DATA_WIDTH - 1 : 0] mem_read_data_MEM;

    wire [`DATA_WIDTH - 1 : 0] mem_address; // 璇诲啓鍐呭瓨鐨勪綅缃?
    assign mem_address = ALU_result_MEM; // 涓?瀹氭槸ALU杩愮畻缁撴灉锛堝瘎瀛樺櫒 + 绔嬪嵆鏁帮級
    // wire [`DATA_WIDTH - 1 : 0] write_mem_data; // 瑕佸啓鍏ュ唴瀛樼殑鏁版嵁
    assign write_mem_data = rs2_data_MEM; // 鍙湁sw鎸囦护锛孌M[imm + rs1] <- rs2
    // RAM data_memory(
    //     .clka(~clk), // 涓嬮檷娌垮啓鍏?
    //     .wea(is_write_mem_future_MEM),
    //     .addra(mem_address[9:0]),
    //     .dina(write_mem_data),
    //     .douta(mem_read_data_MEM)
    // );

    wire [`PC_WIDTH - 1 : 0] pc_4_WB;
    // wire [`REGS_WIDTH - 1 : 0] rd_address_WB;
    wire [`DATA_WIDTH - 1 : 0] ALU_result_WB;
    wire [`DATA_WIDTH - 1 : 0] mem_read_data_WB;
    wire [`MEM_TO_REGS_OPTION_WIDTH - 1 : 0] mem_to_regs_option_WB;
    wire is_write_regs_future_WB;
    wire [`DATA_WIDTH - 1 : 0] immediate_WB;
    MEM_reg_WB MEM_reg_WB(
        .clk(clk_cpu_real),
        .cpu_en(1'b1),
        .rst(rst),
        .in_pc_4(pc_4_MEM),
        .in_rd_address(rd_address_MEM),
        .in_ALU_result(ALU_result_MEM),
        .in_mem_read_data(mem_read_data_MEM),
        .in_mem_to_regs_option(mem_to_regs_option_MEM),
        .in_is_write_regs_future(is_write_regs_future_MEM),
        .in_immediate(immediate_MEM),

        .in_pc(pc_MEM),
        .in_instruction(instruction_MEM),
        .out_instruction(instruction_WB),
        .out_pc(pc_WB),

        .out_pc_4(pc_4_WB),
        .out_rd_address(rd_address_WB),
        .out_ALU_result(ALU_result_WB),
        .out_mem_read_data(mem_read_data_WB),
        .out_mem_to_regs_option(mem_to_regs_option_WB),
        .out_is_write_regs_future(is_write_regs_future_WB),
        .out_immediate(immediate_WB)
    );
    assign write_regs_address = rd_address_WB;

    write_back write_back (
        .pc_4(pc_4_WB),
        .ALU_result(ALU_result_WB),
        .mem_read_data(mem_read_data_WB),
        .immediate(immediate_WB),
        .mem_to_regs_option(mem_to_regs_option_WB),

        .write_data(write_regs_data) // 鍐欏洖ID鐨勫??
    );


    /* stall浣跨敤 */
    assign is_write_regs_ID_EXE = is_write_regs_future_EXE;
    assign rd_address_ID_EXE = rd_address_EXE;
    assign branch_type_ID_EXE = branch_type_EXE;
    assign is_write_regs_EXE_MEM = is_write_regs_future_MEM;
    assign rd_address_EXE_MEM = rd_address_MEM;
    assign branch_type_EXE_MEM = branch_type_MEM;
    /* end stall */

    assign is_write_regs = is_write_regs_future_WB;

    assign is_B_immediate_EXE = (ALU_B_option_ID == `ALU_B_OPTION_IMM) ? 1'b1 : 1'b0;
    assign is_branch_EXE = (branch_type_ID_EXE == `BRANCH_TYPE_BEQ) ? 1'b1 : 1'b0;
    assign is_jal_EXE = (branch_type_ID_EXE == `BRANCH_TYPE_JAL) ? 1'b1 : 1'b0;
    assign is_jalr_EXE = (branch_type_ID_EXE == `BRANCH_TYPE_JALR) ? 1'b1 : 1'b0;
    assign is_jal_MEM = (branch_type_MEM == `BRANCH_TYPE_JAL) ? 1'b1 : 1'b0;
    assign is_jalr_MEM = (branch_type_MEM == `BRANCH_TYPE_JALR) ? 1'b1 : 1'b0;
    
endmodule //pipeline_CPU