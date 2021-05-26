`include "define.v"

module registers (
    input is_write_regs,
    input [`REGS_WIDTH - 1 : 0] write_address,
    input [`DATA_WIDTH - 1 : 0] write_data,
    input [`REGS_WIDTH - 1 : 0] rs1_address,
    input [`REGS_WIDTH - 1 : 0] rs2_address,

    // from <top module>
    input cpu_en,
    input clk,
    input rst, // reset

    output [`DATA_WIDTH - 1 : 0] rs1_data,
    output [`DATA_WIDTH - 1 : 0] rs2_data
);

    reg [`DATA_WIDTH - 1 : 0] registers [1 : `REGS_NUM - 1];

    integer i;
    initial begin
        for (i = 1; i < 32; i = i + 1) begin
            registers[i] = 0;
        end
    end

    assign rs1_data = (rs1_address == 0) ? 0 : registers[rs1_address];
    assign rs2_data = (rs2_address == 0) ? 0 : registers[rs2_address];

    always @(negedge clk) begin // 下降沿写
        if (rst) begin
            for (i = 1;i < 32; i = i + 1) registers[i] <= 0;
        end
        else if (is_write_regs & write_address != 0) begin
            // 写入寄存器
            registers[write_address] <= write_data;
        end
    end

endmodule // regs_file