`include "define.v"
`include "registers.v"


module instruction_decoder (
    // from <instruction fetch>
    input[`INST_WIDTH - 1 : 0] instruction,
    input[`PC_WIDTH - 1 : 0] pc,

    // from <write back>
    input is_write_regs,    // 是否要在寄存器写入值
    input[`REGS_WIDTH - 1 : 0] write_address,  // 写入寄存器地址
    input[`DATA_WIDTH - 1 : 0] write_data,  // 写入寄存器数据

    // from <execution>
    input [`DATA_WIDTH - 1 : 0] EXE_ALU_result, // ALU计算结果
    
    // from <memory access>
    input [`DATA_WIDTH - 1 : 0] MEM_ALU_result, // ALU计算结果
    input [`DATA_WIDTH - 1 : 0] MEM_read_result, // 读取data memory结果

    // from <top module>
    input cpu_en,
    input clk,
    input rst, // reset

    // to <instruction fetch>
    output reg is_branch,
    output is_stall,
    output reg [`PC_WIDTH - 1 : 0] branch_pc,

    // to <execution>
    output [`DATA_WIDTH - 1 : 0] immediate,
    output reg [`DATA_WIDTH - 1 : 0] ALU_A,
    output reg [`DATA_WIDTH - 1 : 0] ALU_B,
    output [`ALU_OPTION_WIDTH - 1 : 0] ALU_option,

    // 控制信号
    output is_write_MEM_future, // 这条指令过段时间是否要写入data memory
    output is_write_regs_future, // 这条指令过段时间是否要写入ID中的寄存器

    output is_MEM_forward_ALU_A, // ALU运算的A是否来自MEM读取
    output is_MEM_forward_ALU_B // ALU运算的B是否来自MEM读取
);
    wire [`REGS_WIDTH - 1 : 0] rs1_address;
    wire [`REGS_WIDTH - 1 : 0] rs2_address;
    wire [`REGS_WIDTH - 1 : 0] rd_address;


    wire [`A_OPTION_WIDTH - 1 : 0] A_option; // 选择作为ALU输入的A
    wire [`B_OPTION_WIDTH - 1 : 0] B_option; // 选择作为ALU输入的B
    wire [`BRANCH_OPTION_WIDTH - 1 : 0] branch_option; // 选择跳转类型


    assign is_MEM_forward_ALU_A = (A_option == `MEM_READ_FORWARD_EXE) ? 1 : 0;
    assign is_MEM_forward_ALU_B = (B_option == `MEM_READ_FORWARD_EXE) ? 1 : 0;
    
    controller controller (
        .cpu_en(cpu_en),
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .EXE_ALU_result(EXE_ALU_result),
        .MEM_ALU_result(MEM_ALU_result),
        .MEM_read_result(MEM_read_result),
        .rs1_address(rs1_address),
        .rs2_address(rs2_address),
        .rd_address(rd_address),
        .ALU_option(ALU_option),
        .is_write_regs_future(is_write_regs_future),
        .A_option(A_option),
        .B_option(B_option),
        .is_stall(is_stall),
        .is_write_MEM_future(is_write_MEM_future),
        .immediate(immediate),
        .branch_option(branch_option)
    );

    wire [`DATA_WIDTH - 1 : 0] rs1_data;
    wire [`DATA_WIDTH - 1 : 0] rs2_data;
    
    registers registers(
        .clk(clk),
        .rst(rst),
        .cpu_en(cpu_en),
        .is_write_regs(is_write_regs),
        .write_address(write_address),
        .write_data(write_data),
        .rs1_address(rs1_address),
        .rs2_address(rs2_address),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // branch相关的计算都是组合电路
    // 因为可能在下降沿才能读到真正的rs1/rs2【采用double bump以后，下降沿写入registers】
    always @(*) begin
        case (A_option)
            `A_REGS:    ALU_A = rs1_data;
            `EXE_ALU:   ALU_A = EXE_ALU_result;
            `MEM_ALU:   ALU_A = MEM_ALU_result;
            `MEM_READ:  ALU_A = MEM_read_result;
            `IMMEDIATE: ALU_A = immediate;
        endcase
        case (B_option)
            `B_REGS:    ALU_B = rs2_data;
            `EXE_ALU:   ALU_B = EXE_ALU_result;
            `MEM_ALU:   ALU_B = MEM_ALU_result;
            `MEM_READ:  ALU_B = MEM_read_result;
            `IMMEDIATE: ALU_B = immediate;
        endcase
        case (branch_option)
            `BRANCH_BEQ:
                if (rs1_data == rs2_data) is_branch = 1;
                else is_branch = 0;
            `BRANCH_BNE:
                if (rs1_data != rs2_data) is_branch = 1;
                else is_branch = 0;
            default:
                is_branch = 0;
        endcase
        branch_pc = pc + immediate;
    end

endmodule //instruction_decoder


module controller (
    // from <top module>
    input cpu_en,
    input clk,
    input rst, // reset

    input [`INST_WIDTH - 1 : 0] instruction,

    // from <execution>
    input [`DATA_WIDTH - 1 : 0] EXE_ALU_result,
    // from <memory access>
    input [`DATA_WIDTH - 1 : 0] MEM_ALU_result,
    input [`DATA_WIDTH - 1 : 0] MEM_read_result,

    output [`REGS_WIDTH - 1 : 0] rs1_address,
    output [`REGS_WIDTH - 1 : 0] rs2_address,
    output [`REGS_WIDTH - 1 : 0] rd_address,
    output reg is_write_regs_future, // 当前指令将来是否会写入寄存器
    output reg is_write_MEM_future, // 当前指令将来是否会写入memory access
    output reg [`DATA_WIDTH - 1 : 0] immediate, // 扩展的立即数
    output reg [`ALU_OPTION_WIDTH - 1 : 0] ALU_option,

    output reg [`BRANCH_OPTION_WIDTH - 1 : 0] branch_option,

    output reg [`A_OPTION_WIDTH - 1 : 0] A_option, // 选择作为ALU输入的A
    output reg [`B_OPTION_WIDTH - 1 : 0] B_option, // 选择作为ALU输入的B

    output reg is_stall // load指令后面紧接要读取时，需要一个stall
);

    assign rs1_address = instruction[`RS1_RANGE];
    assign rs2_address = instruction[`RS2_RANGE];
    assign rd_address = instruction[`RD_RANGE];


    reg is_MEM_read_to_regs_future; // 当前指令是否要用到data memory读取的值
    reg is_read_rs1, is_read_rs2; // 当前指令是否要用到rs1, rs2

    // 在data memory读取出得数据需要写入的寄存器地址
    `define IN_EXE 0    // 表示这个数据目前在execution阶段
    `define IN_MEM 1    // 表示这个数据目前在memory access阶段
    reg [`REGS_WIDTH - 1 : 0] MEM_read_to_regs_address [`IN_MEM : `IN_EXE];
    reg [`REGS_WIDTH - 1 : 0] ALU_result_to_regs_address [`IN_MEM : `IN_EXE]; // ALU result要写入的地址

    // 更新地址buffer
    initial begin
        is_write_MEM_future = 0; 
        is_write_regs_future = 0;
        is_MEM_read_to_regs_future = 0;
        is_read_rs1 = 0;
        is_read_rs2 = 0;
        branch_option = `BRANCH_NA;
    end

    // 解析instruction
    always @(posedge clk) begin
        if (rst) begin
            is_write_MEM_future <= 0;
            is_write_regs_future <= 0;
            is_MEM_read_to_regs_future <= 0;
            is_read_rs1 <= 0;
            is_read_rs2 <= 0;
            branch_option <= `BRANCH_NA;
        end
        else if (cpu_en) begin
            // 先把控制信号清零
            case (instruction[`OP_RANGE])
                `OP_R_TYPE:
                    begin
                        $display("R type");
                        is_write_MEM_future <= 0;
                        is_MEM_read_to_regs_future <= 0;
                        is_write_regs_future <= 1;
                        is_read_rs1 <= 1;
                        is_read_rs2 <= 1;
                        branch_option <= `BRANCH_NA;

                        case ({instruction[`FUNCT3_RANGE], instruction[`FUNCT7_RANGE]})
                            `FUNCT_ADD: ALU_option <= `ALU_ADD;
                            `FUNCT_SUB: ALU_option <= `ALU_SUB;
                            `FUNCT_OR:  ALU_option <= `ALU_OR;
                            default: 
                                $display("Unknown funct3: %b, funct7: %b", instruction[`FUNCT3_RANGE], instruction[`FUNCT7_RANGE]);
                        endcase
                    end
                `OP_LOAD:
                    begin
                        $display("load");
                        is_write_MEM_future <= 0;
                        is_MEM_read_to_regs_future <= 1;
                        is_write_regs_future <= 1;
                        is_read_rs1 <= 1;
                        is_read_rs2 <= 0;
                        branch_option <= `BRANCH_NA;

                        immediate <= {20'b0, instruction[`LOAD_IMM_RANGE]};

                        case (instruction[`FUNCT3_RANGE])
                            `FUNCT3_LW: 
                                begin
                                    ALU_option <= `ALU_ADD; // load word，要做加法
                                    // B_option <= `IMMEDIATE; // 要做 data(rs1) + immediate
                                end
                            default:
                                $display("Unknown funct3: %b", instruction[`FUNCT3_RANGE]);
                        endcase
                    end
                `OP_I_ARITHMETIC:
                    begin
                        $display("arithmetic");
                        is_write_MEM_future <= 0;
                        is_MEM_read_to_regs_future <= 0;
                        is_write_regs_future <= 1;
                        is_read_rs1 <= 1;
                        is_read_rs2 <= 0;
                        branch_option <= `BRANCH_NA;

                        case (instruction[`FUNCT3_RANGE])
                            `FUNCT3_ADDI:
                                begin
                                    ALU_option <= `ALU_ADD;
                                    // B_option <= `IMMEDIATE;
                                    immediate <= {20'b0, instruction[`ADDI_IMM_RANGE]};
                                end
                            default:
                                $display("Unknown funct3: %b", instruction[`FUNCT3_RANGE]);
                        endcase
                    end
                `OP_S_TYPE:
                    begin
                        $display("s type");
                        is_write_MEM_future <= 1; // 要写入DM
                        is_MEM_read_to_regs_future <= 0;
                        is_write_regs_future <= 0;
                        is_read_rs1 <= 1;
                        is_read_rs2 <= 1;
                        branch_option <= `BRANCH_NA;
                        ALU_option <= `ALU_ADD;
                        immediate <= {20'b0, immediate[`S_IMM_RANGE_HIGH], immediate[`S_IMM_RANGE_LOW]};

                        case (instruction[`FUNCT3_RANGE])
                            `FUNCT3_SW:
                                begin
                                    $display("funct3: sw");
                                end
                            default:
                                $display("Unknown funct3: %b", instruction[`FUNCT3_RANGE]);
                        endcase
                    end
                `OP_SB_TYPE:
                    begin
                        $display("sb type");
                        is_MEM_read_to_regs_future <= 0;
                        is_write_regs_future <= 0;
                        is_read_rs1 <= 1;
                        is_read_rs2 <= 1;
                        immediate = {19'b0, instruction[`SB_IMM_RANGE_1], instruction[`SB_IMM_RANGE_2], 
                                            instruction[`SB_IMM_RANGE_3], instruction[`SB_IMM_RANGE_4], 1'b0}; // 最后一位默认补0

                        case (instruction[`FUNCT3_RANGE])
                            `FUNCT3_BEQ: branch_option <= `BRANCH_BEQ;
                            `FUNCT3_BNE: branch_option <= `BRANCH_BNE;
                            default:
                                $display("Unknown funct3: %b", instruction[`FUNCT3_RANGE]);
                        endcase
                    end
                `OP_U_TYPE:
                    $display("u type");
                `OP_UJ_TYPE:
                    $display("uj type");
                default:
                    begin
                        $display("Unknown op code: %b", instruction[`OP_RANGE]);
                    end
            endcase
        end
    end

    // 处理stall和forward
    initial begin
        // 地址buffer
        MEM_read_to_regs_address[`IN_EXE] = 0;
        MEM_read_to_regs_address[`IN_MEM] = 0;
        ALU_result_to_regs_address[`IN_EXE] = 0;
        ALU_result_to_regs_address[`IN_MEM] = 0;
    end
    always @(negedge clk) begin
        if (rst) begin
            // 地址buffer
            MEM_read_to_regs_address[`IN_EXE] <= 0;
            MEM_read_to_regs_address[`IN_MEM] <= 0;
            ALU_result_to_regs_address[`IN_EXE] <= 0;
            ALU_result_to_regs_address[`IN_MEM] <= 0;
            A_option <= 0;
            B_option <= 0;
        end
        else if (cpu_en) begin
            // 是否要stall
            if ((rs1_address == MEM_read_to_regs_address[`IN_EXE] & branch_option != `BRANCH_NA)
               |(rs2_address == MEM_read_to_regs_address[`IN_EXE] & branch_option != `BRANCH_NA))
                begin
                    // 如果上一条指令是load
                    // 并且当前指令需要用到上一条从data memory读取的值
                    // 并且branch指令用到上一个load指令的寄存器
                    // 则必须stall一个时钟
                    is_stall <= 1;
                end
                else is_stall <= 0; // 否则都能通过forward解决

            /* 选择ALU的输入 */
            if (is_read_rs1) begin
                case (rs1_address) 
                    0: begin
                        A_option <= `A_REGS;
                    end
                    MEM_read_to_regs_address[`IN_EXE]: begin
                        if (branch_option == `BRANCH_NA) begin // ALU的A输入就是从DM forward过来的
                            // 当前指令使用rs1进行ALU运算
                            // 所以从memory access forward到execution
                            A_option <= `MEM_READ_FORWARD_EXE;
                        end
                        else begin 
                            // 这时候stall
                            A_option <= 0;
                        end
                    end
                    MEM_read_to_regs_address[`IN_MEM]: begin
                        // 上上条指令是laod
                        // 并且当前指令需要用到上上条从data memory读取的值
                        // 所以把memory forward中从内存读到的数forward到instruction decoder
                        A_option <= `MEM_READ;
                    end
                    ALU_result_to_regs_address[`IN_EXE]: begin
                        // 上条ALU指令要写入rd
                        // 并且当前rs1要读取上条ALU结果的值
                        // 所以就从execution forward到instruction decoder
                        A_option <= `EXE_ALU;
                    end
                    ALU_result_to_regs_address[`IN_MEM]: begin
                        // 上上条ALU指令要写入rd
                        // 并且当前rs1要读取上上条ALU结果的值   
                        // 所以就把memory access中ALU结果forward到instruction decoder
                        A_option <= `MEM_ALU;
                    end
                    default: begin
                        // 默认都是用寄存器
                        A_option <= `A_REGS;
                    end
                endcase
            end
            else begin
                A_option <= `IMMEDIATE; // 默认不用register值时，使用立即数
            end

            // rs2同理
            if (is_read_rs2) begin
                case (rs2_address) 
                    0: begin
                        B_option <= `A_REGS;
                    end
                    MEM_read_to_regs_address[`IN_EXE]: begin
                        if (branch_option == `BRANCH_NA) begin // ALU的A输入就是从DM forward过来的
                            // 当前指令使用rs1进行ALU运算
                            // 所以从memory access forward到execution
                            B_option <= `MEM_READ_FORWARD_EXE;
                        end
                        else begin 
                            // 这时候stall
                            B_option <= 0;
                        end
                    end
                    MEM_read_to_regs_address[`IN_MEM]: begin
                        // 上上条指令是laod
                        // 并且当前指令需要用到上上条从data memory读取的值
                        // 所以把memory forward中从内存读到的数forward到instruction decoder
                        B_option <= `MEM_READ;
                    end
                    ALU_result_to_regs_address[`IN_EXE]: begin
                        // 上条ALU指令要写入rd
                        // 并且当前rs1要读取上条ALU结果的值
                        // 所以就从execution forward到instruction decoder
                        B_option <= `EXE_ALU;
                    end
                    ALU_result_to_regs_address[`IN_MEM]: begin
                        // 上上条ALU指令要写入rd
                        // 并且当前rs1要读取上上条ALU结果的值   
                        // 所以就把memory access中ALU结果forward到instruction decoder
                        B_option <= `MEM_ALU;
                    end
                    default: begin
                        // 默认都是用寄存器
                        B_option <= `B_REGS;
                    end
                endcase
            end
            else begin
                B_option <= `IMMEDIATE; // 默认不用register值时，使用立即数
            end
            
            if (is_write_regs_future) begin
                // 如果将来要写入寄存器
                if (is_MEM_read_to_regs_future) begin
                    // 如果写入的值来自data memory
                    ALU_result_to_regs_address[`IN_EXE] <= 0;
                    MEM_read_to_regs_address[`IN_EXE] <= rd_address;
                    if (rd_address == MEM_read_to_regs_address[`IN_EXE]) begin
                        // 如果上条指令写的是同一个rd
                        // 那么上条读取结果对后面的指令不可见
                        MEM_read_to_regs_address[`IN_MEM] <= 0;

                        ALU_result_to_regs_address[`IN_MEM] <= ALU_result_to_regs_address[`IN_EXE];
                    end
                    else if (rd_address == ALU_result_to_regs_address[`IN_EXE]) begin
                        MEM_read_to_regs_address[`IN_MEM] <= MEM_read_to_regs_address[`IN_EXE];

                        ALU_result_to_regs_address[`IN_MEM] <= 0;
                    end
                    else begin
                        // 连续两个指令写的是不一样的值
                        // buffer向前推进
                        MEM_read_to_regs_address[`IN_MEM] <= MEM_read_to_regs_address[`IN_EXE];

                        ALU_result_to_regs_address[`IN_MEM] <= ALU_result_to_regs_address[`IN_EXE];
                    end
                end
                else begin
                    // 否则，写入的值一定来自ALU
                    ALU_result_to_regs_address[`IN_EXE] <= rd_address;
                    MEM_read_to_regs_address[`IN_EXE] <= 0;

                    if (rd_address == MEM_read_to_regs_address[`IN_EXE]) begin
                        // 如果上条指令写的是同一个rd
                        // 那么上条读取结果对后面的指令不可见
                        MEM_read_to_regs_address[`IN_MEM] <= 0;

                        ALU_result_to_regs_address[`IN_MEM] <= ALU_result_to_regs_address[`IN_EXE];
                    end
                    else if (rd_address == ALU_result_to_regs_address[`IN_EXE]) begin
                        MEM_read_to_regs_address[`IN_MEM] <= MEM_read_to_regs_address[`IN_EXE];

                        ALU_result_to_regs_address[`IN_MEM] <= 0;
                    end
                    else begin
                        // 连续两个指令写的是不一样的值
                        // buffer向前推进
                        MEM_read_to_regs_address[`IN_MEM] <= MEM_read_to_regs_address[`IN_EXE];

                        ALU_result_to_regs_address[`IN_MEM] <= ALU_result_to_regs_address[`IN_EXE];
                    end
                end
            end 
            else begin
                // 不写入寄存器，简单向前推进
                MEM_read_to_regs_address[`IN_EXE] <= 0;
                MEM_read_to_regs_address[`IN_MEM] <= MEM_read_to_regs_address[`IN_EXE];
                
                ALU_result_to_regs_address[`IN_EXE] <= 0;
                ALU_result_to_regs_address[`IN_MEM] <= ALU_result_to_regs_address[`IN_EXE];
            end

            `ifdef DEBUG
                $display("*******************************");
                $display("instruction: %h", instruction);
                $display("MEM_read_to_regs_address: (%d, %d)", MEM_read_to_regs_address[`IN_EXE], MEM_read_to_regs_address[`IN_MEM]);
                $display("ALU_result_to_regs_address: (%d, %d)", ALU_result_to_regs_address[`IN_EXE], ALU_result_to_regs_address[`IN_MEM]);
                $display("*******************************");
            `endif
        end
    end

endmodule