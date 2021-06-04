//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
//Date        : Fri Jun  4 20:37:44 2021
//Host        : CST509N60 running 64-bit major release  (build 9200)
//Command     : generate_target CSSTE.bd
//Design      : CSSTE
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "CSSTE,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=CSSTE,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=30,numReposBlks=30,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "CSSTE.hwdef" *) 
module CSSTE
   (BTN_y,
    Blue,
    Green,
    HSYNC,
    LED_PEN,
    RSTN,
    Red,
    SEG_PEN,
    SW,
    VSYNC,
    clk_100mhz,
    led_clk,
    led_clrn,
    led_sout,
    seg_clk,
    seg_clrn,
    seg_sout);
  input [3:0]BTN_y;
  output [3:0]Blue;
  output [3:0]Green;
  output HSYNC;
  output LED_PEN;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RSTN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RSTN, POLARITY ACTIVE_HIGH" *) input RSTN;
  output [3:0]Red;
  output SEG_PEN;
  input [15:0]SW;
  output VSYNC;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_100MHZ CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_100MHZ, ASSOCIATED_RESET RSTN, CLK_DOMAIN CSSTE_clk_100mhz, FREQ_HZ 100000000, PHASE 0.000" *) input clk_100mhz;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.LED_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.LED_CLK, CLK_DOMAIN CSSTE_SPIO_0_0_led_clk, FREQ_HZ 100000000, PHASE 0.000" *) output led_clk;
  output led_clrn;
  output led_sout;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SEG_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SEG_CLK, CLK_DOMAIN CSSTE_SSeg7_Dev_0_0_seg_clk, FREQ_HZ 100000000, PHASE 0.000" *) output seg_clk;
  output seg_clrn;
  output seg_sout;

  wire [0:0]BTN_OK0_Dout;
  wire [3:0]Key_y_0_1;
  wire [9:0]PC11_2_Dout;
  wire [29:0]PC31_2_Dout;
  wire RSTN_0_1;
  wire [3:0]SAnti_jitter_0_BTN_OK;
  wire [15:0]SAnti_jitter_0_SW_OK;
  wire SAnti_jitter_0_rst;
  wire [0:0]SW2_Dout;
  wire [0:0]SW8_Dout;
  wire [15:0]SW_0_1;
  wire U10_counter0_OUT;
  wire U10_counter1_OUT;
  wire U10_counter2_OUT;
  wire [31:0]U10_counter_out;
  wire U11_hs;
  wire [3:0]U11_vga_b;
  wire [3:0]U11_vga_g;
  wire [3:0]U11_vga_r;
  wire U11_vs;
  wire [2:0]U1_ALU_option_EXE;
  wire [31:0]U1_ALU_result_MEM;
  wire [31:0]U1_Data_out;
  wire [31:0]U1_PC_out;
  wire [991:0]U1_flatten_registers;
  wire [31:0]U1_immediate_EXE;
  wire [31:0]U1_instruction_EXE;
  wire [31:0]U1_instruction_ID;
  wire [31:0]U1_instruction_MEM;
  wire [31:0]U1_instruction_WB;
  wire U1_is_B_immediate_EXE;
  wire U1_is_branch_EXE;
  wire U1_is_jal_EXE;
  wire U1_is_jal_MEM;
  wire U1_is_jalr_EXE;
  wire U1_is_jalr_MEM;
  wire U1_is_lui_EXE;
  wire U1_is_write_mem_future_EXE;
  wire U1_is_write_regs;
  wire U1_is_write_regs_future_EXE;
  wire U1_is_write_regs_future_MEM;
  wire [31:0]U1_pc_EXE;
  wire [31:0]U1_pc_ID;
  wire [31:0]U1_pc_MEM;
  wire [31:0]U1_pc_WB;
  wire [4:0]U1_rd_address_EXE;
  wire [4:0]U1_rd_address_MEM;
  wire [4:0]U1_rd_address_WB;
  wire [4:0]U1_rs1_address_EXE;
  wire [31:0]U1_rs1_data_EXE;
  wire [4:0]U1_rs2_address_EXE;
  wire [31:0]U1_rs2_data_EXE;
  wire [31:0]U1_write_regs_data;
  wire [31:0]U2_spo;
  wire [31:0]U3_douta;
  wire [31:0]U4_Cpu_data4bus;
  wire U4_GPIOe0000000_we;
  wire U4_GPIOf0000000_we;
  wire [31:0]U4_Peripheral_in;
  wire U4_counter_we;
  wire U4_data_ram_we;
  wire [9:0]U4_ram_addr;
  wire [31:0]U4_ram_data_in;
  wire [31:0]U5_Disp_num;
  wire [7:0]U5_LE_out;
  wire [7:0]U5_point_out;
  wire U6_SEG_PEN;
  wire U6_seg_clk;
  wire U6_seg_clrn;
  wire U6_seg_sout;
  wire U7_LED_PEN;
  wire [15:0]U7_LED_out;
  wire [1:0]U7_counter_set;
  wire U7_led_clk;
  wire U7_led_clrn;
  wire U7_led_sout;
  wire U8_Clk_CPU;
  wire [31:0]U8_clkdiv;
  wire [1:0]b2_0_dout;
  wire clk_0_1;
  wire [0:0]div11_Dout;
  wire [0:0]div1_Dout;
  wire [0:0]div20_Dout;
  wire [0:0]div25_Dout;
  wire [0:0]div6_Dout;
  wire [0:0]div9_Dout;
  wire pipeline_CPU_0_is_write_mem_future_MEM;
  wire [0:0]sw0_Dout;
  wire [2:0]sw7_5_Dout;
  wire [0:0]util_vector_logic_0_Res;
  wire [0:0]util_vector_logic_1_Res;
  wire [63:0]xlconcat_0_dout;
  wire [31:0]xlconcat_1_dout;
  wire [63:0]xlconstant_0_dout;

  assign Blue[3:0] = U11_vga_b;
  assign Green[3:0] = U11_vga_g;
  assign HSYNC = U11_hs;
  assign Key_y_0_1 = BTN_y[3:0];
  assign LED_PEN = U7_LED_PEN;
  assign RSTN_0_1 = RSTN;
  assign Red[3:0] = U11_vga_r;
  assign SEG_PEN = U6_SEG_PEN;
  assign SW_0_1 = SW[15:0];
  assign VSYNC = U11_vs;
  assign clk_0_1 = clk_100mhz;
  assign led_clk = U7_led_clk;
  assign led_clrn = U7_led_clrn;
  assign led_sout = U7_led_sout;
  assign seg_clk = U6_seg_clk;
  assign seg_clrn = U6_seg_clrn;
  assign seg_sout = U6_seg_sout;
  CSSTE_xlslice_0_0 BTN_OK0
       (.Din(SAnti_jitter_0_BTN_OK),
        .Dout(BTN_OK0_Dout));
  CSSTE_BTN_OK0_0 PC11_2
       (.Din(U1_PC_out),
        .Dout(PC11_2_Dout));
  CSSTE_xlslice_0_4 PC31_2
       (.Din(U1_PC_out),
        .Dout(PC31_2_Dout));
  CSSTE_xlslice_0_1 SW2
       (.Din(SAnti_jitter_0_SW_OK),
        .Dout(SW2_Dout));
  CSSTE_xlslice_0_2 SW8
       (.Din(SAnti_jitter_0_SW_OK),
        .Dout(SW8_Dout));
  CSSTE_pipeline_CPU_0_0 U1
       (.ALU_option_EXE(U1_ALU_option_EXE),
        .ALU_result_MEM(U1_ALU_result_MEM),
        .clk(U8_Clk_CPU),
        .flatten_registers(U1_flatten_registers),
        .immediate_EXE(U1_immediate_EXE),
        .instruction_EXE(U1_instruction_EXE),
        .instruction_ID(U1_instruction_ID),
        .instruction_IF(U2_spo),
        .instruction_MEM(U1_instruction_MEM),
        .instruction_WB(U1_instruction_WB),
        .is_B_immediate_EXE(U1_is_B_immediate_EXE),
        .is_branch_EXE(U1_is_branch_EXE),
        .is_jal_EXE(U1_is_jal_EXE),
        .is_jal_MEM(U1_is_jal_MEM),
        .is_jalr_EXE(U1_is_jalr_EXE),
        .is_jalr_MEM(U1_is_jalr_MEM),
        .is_lui_EXE(U1_is_lui_EXE),
        .is_write_mem_future_EXE(U1_is_write_mem_future_EXE),
        .is_write_mem_future_MEM(pipeline_CPU_0_is_write_mem_future_MEM),
        .is_write_regs(U1_is_write_regs),
        .is_write_regs_future_EXE(U1_is_write_regs_future_EXE),
        .is_write_regs_future_MEM(U1_is_write_regs_future_MEM),
        .mem_read_data_MEM(U4_Cpu_data4bus),
        .pc_EXE(U1_pc_EXE),
        .pc_ID(U1_pc_ID),
        .pc_IF(U1_PC_out),
        .pc_MEM(U1_pc_MEM),
        .pc_WB(U1_pc_WB),
        .rd_address_EXE(U1_rd_address_EXE),
        .rd_address_MEM(U1_rd_address_MEM),
        .rd_address_WB(U1_rd_address_WB),
        .rs1_address_EXE(U1_rs1_address_EXE),
        .rs1_data_EXE(U1_rs1_data_EXE),
        .rs2_address_EXE(U1_rs2_address_EXE),
        .rs2_data_EXE(U1_rs2_data_EXE),
        .rst(SAnti_jitter_0_rst),
        .write_mem_data(U1_Data_out),
        .write_regs_data(U1_write_regs_data));
  CSSTE_Counter_x_0_0 U10
       (.clk(util_vector_logic_1_Res),
        .clk0(div6_Dout),
        .clk1(div9_Dout),
        .clk2(div11_Dout),
        .counter0_OUT(U10_counter0_OUT),
        .counter1_OUT(U10_counter1_OUT),
        .counter2_OUT(U10_counter2_OUT),
        .counter_ch(U7_counter_set),
        .counter_out(U10_counter_out),
        .counter_val(U4_Peripheral_in),
        .counter_we(U4_counter_we),
        .rst(SAnti_jitter_0_rst));
  CSSTE_VGA_0_0 U11
       (.ALU_option_EXE(U1_ALU_option_EXE),
        .ALU_result_MEM(U1_ALU_result_MEM),
        .MemRW_Ex(U1_is_write_mem_future_EXE),
        .MemRW_Mem(pipeline_CPU_0_is_write_mem_future_MEM),
        .clk_100m(clk_0_1),
        .clk_25m(div1_Dout),
        .flatten_registers(U1_flatten_registers),
        .hs(U11_hs),
        .immediate_EXE(U1_immediate_EXE),
        .inst_ID(U1_instruction_ID),
        .inst_IF(U2_spo),
        .instruction_EXE(U1_instruction_EXE),
        .instruction_MEM(U1_instruction_MEM),
        .instruction_WB(U1_instruction_WB),
        .is_B_immediate_EXE(U1_is_B_immediate_EXE),
        .is_branch_EXE(U1_is_branch_EXE),
        .is_jal_EXE(U1_is_jal_EXE),
        .is_jal_MEM(U1_is_jal_MEM),
        .is_jalr_EXE(U1_is_jalr_EXE),
        .is_jalr_MEM(U1_is_jalr_MEM),
        .is_lui_EXE(U1_is_lui_EXE),
        .is_write_regs(U1_is_write_regs),
        .is_write_regs_future_EXE(U1_is_write_regs_future_EXE),
        .is_write_regs_future_MEM(U1_is_write_regs_future_MEM),
        .pc_EXE(U1_pc_EXE),
        .pc_ID(U1_pc_ID),
        .pc_IF(U1_PC_out),
        .pc_MEM(U1_pc_MEM),
        .pc_WB(U1_pc_WB),
        .rd_address_EXE(U1_rd_address_EXE),
        .rd_address_MEM(U1_rd_address_MEM),
        .rd_address_WB(U1_rd_address_WB),
        .rs1_address_EXE(U1_rs1_address_EXE),
        .rs1_data_EXE(U1_rs1_data_EXE),
        .rs2_address_EXE(U1_rs2_address_EXE),
        .rs2_data_EXE(U1_rs2_data_EXE),
        .rst(SAnti_jitter_0_rst),
        .vga_b(U11_vga_b),
        .vga_g(U11_vga_g),
        .vga_r(U11_vga_r),
        .vs(U11_vs),
        .write_mem_data(U1_Data_out),
        .write_regs_data(U1_write_regs_data));
  CSSTE_dist_mem_gen_0_0 U2
       (.a(PC11_2_Dout),
        .spo(U2_spo));
  CSSTE_RAM_B_0_0 U3
       (.addra(U4_ram_addr),
        .clka(util_vector_logic_0_Res),
        .dina(U4_ram_data_in),
        .douta(U3_douta),
        .wea(U4_data_ram_we));
  CSSTE_MIO_BUS_0_0 U4
       (.BTN(SAnti_jitter_0_BTN_OK),
        .Cpu_data2bus(U1_Data_out),
        .Cpu_data4bus(U4_Cpu_data4bus),
        .GPIOe0000000_we(U4_GPIOe0000000_we),
        .GPIOf0000000_we(U4_GPIOf0000000_we),
        .Peripheral_in(U4_Peripheral_in),
        .SW(SAnti_jitter_0_SW_OK),
        .addr_bus(U1_ALU_result_MEM),
        .clk(clk_0_1),
        .counter0_out(U10_counter0_OUT),
        .counter1_out(U10_counter1_OUT),
        .counter2_out(U10_counter2_OUT),
        .counter_out(U10_counter_out),
        .counter_we(U4_counter_we),
        .data_ram_we(U4_data_ram_we),
        .led_out(U7_LED_out),
        .mem_w(pipeline_CPU_0_is_write_mem_future_MEM),
        .ram_addr(U4_ram_addr),
        .ram_data_in(U4_ram_data_in),
        .ram_data_out(U3_douta),
        .rst(SAnti_jitter_0_rst));
  CSSTE_Multi_8CH32_0_0 U5
       (.Data0(U4_Peripheral_in),
        .Disp_num(U5_Disp_num),
        .EN(U4_GPIOe0000000_we),
        .LES(xlconstant_0_dout),
        .LE_out(U5_LE_out),
        .Test(sw7_5_Dout),
        .clk(util_vector_logic_1_Res),
        .data1(xlconcat_1_dout),
        .data2(U2_spo),
        .data3(U10_counter_out),
        .data4(U1_ALU_result_MEM),
        .data5(U1_Data_out),
        .data6(U4_Cpu_data4bus),
        .data7(U1_PC_out),
        .point_in(xlconcat_0_dout),
        .point_out(U5_point_out),
        .rst(SAnti_jitter_0_rst));
  CSSTE_SSeg7_Dev_0_0 U6
       (.Hexs(U5_Disp_num),
        .LES(U5_LE_out),
        .SEG_PEN(U6_SEG_PEN),
        .SW0(sw0_Dout),
        .Start(div20_Dout),
        .clk(clk_0_1),
        .flash(div25_Dout),
        .point(U5_point_out),
        .rst(SAnti_jitter_0_rst),
        .seg_clk(U6_seg_clk),
        .seg_clrn(U6_seg_clrn),
        .seg_sout(U6_seg_sout));
  CSSTE_SPIO_0_0 U7
       (.EN(U4_GPIOf0000000_we),
        .LED_PEN(U7_LED_PEN),
        .LED_out(U7_LED_out),
        .P_Data(U4_Peripheral_in),
        .Start(div20_Dout),
        .clk(util_vector_logic_1_Res),
        .counter_set(U7_counter_set),
        .led_clk(U7_led_clk),
        .led_clrn(U7_led_clrn),
        .led_sout(U7_led_sout),
        .rst(SAnti_jitter_0_rst));
  CSSTE_clk_div_0_0 U8
       (.Clk_CPU(U8_Clk_CPU),
        .STEP(BTN_OK0_Dout),
        .SW2(SW2_Dout),
        .SW8(SW8_Dout),
        .clk(clk_0_1),
        .clkdiv(U8_clkdiv),
        .rst(SAnti_jitter_0_rst));
  CSSTE_SAnti_jitter_0_0 U9
       (.BTN_OK(SAnti_jitter_0_BTN_OK),
        .Key_y(Key_y_0_1),
        .RSTN(RSTN_0_1),
        .SW(SW_0_1),
        .SW_OK(SAnti_jitter_0_SW_OK),
        .clk(clk_0_1),
        .readn(1'b0),
        .rst(SAnti_jitter_0_rst));
  CSSTE_xlconstant_0_0 b2_0
       (.dout(b2_0_dout));
  CSSTE_div20_0 div1
       (.Din(U8_clkdiv),
        .Dout(div1_Dout));
  CSSTE_SW8_0 div11
       (.Din(U8_clkdiv),
        .Dout(div11_Dout));
  CSSTE_xlslice_0_3 div20
       (.Din(U8_clkdiv),
        .Dout(div20_Dout));
  CSSTE_xlslice_0_7 div25
       (.Din(U8_clkdiv),
        .Dout(div25_Dout));
  CSSTE_SW8_2 div6
       (.Din(U8_clkdiv),
        .Dout(div6_Dout));
  CSSTE_SW8_1 div9
       (.Din(U8_clkdiv),
        .Dout(div9_Dout));
  CSSTE_xlslice_0_6 sw0
       (.Din(SAnti_jitter_0_SW_OK),
        .Dout(sw0_Dout));
  CSSTE_xlslice_0_5 sw7_5
       (.Din(SAnti_jitter_0_SW_OK),
        .Dout(sw7_5_Dout));
  CSSTE_util_vector_logic_0_0 util_vector_logic_0
       (.Op1(clk_0_1),
        .Res(util_vector_logic_0_Res));
  CSSTE_util_vector_logic_0_1 util_vector_logic_1
       (.Op1(U8_Clk_CPU),
        .Res(util_vector_logic_1_Res));
  CSSTE_xlconcat_0_0 xlconcat_0
       (.In0(U8_clkdiv),
        .In1(U8_clkdiv),
        .dout(xlconcat_0_dout));
  CSSTE_xlconcat_1_0 xlconcat_1
       (.In0(PC31_2_Dout),
        .In1(b2_0_dout),
        .dout(xlconcat_1_dout));
  CSSTE_xlconstant_0_1 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule
