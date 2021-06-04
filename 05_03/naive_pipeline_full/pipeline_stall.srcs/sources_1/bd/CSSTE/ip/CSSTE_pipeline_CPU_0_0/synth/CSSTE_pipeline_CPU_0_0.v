// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:user:pipeline_CPU:1.0
// IP Revision: 6

(* X_CORE_INFO = "pipeline_CPU,Vivado 2017.4" *)
(* CHECK_LICENSE_TYPE = "CSSTE_pipeline_CPU_0_0,pipeline_CPU,{}" *)
(* CORE_GENERATION_INFO = "CSSTE_pipeline_CPU_0_0,pipeline_CPU,{x_ipProduct=Vivado 2017.4,x_ipVendor=xilinx.com,x_ipLibrary=user,x_ipName=pipeline_CPU,x_ipVersion=1.0,x_ipCoreRevision=6,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module CSSTE_pipeline_CPU_0_0 (
  clk,
  rst,
  instruction_IF,
  mem_read_data_MEM,
  pc_IF,
  pc_ID,
  instruction_ID,
  pc_EXE,
  is_write_mem_future_EXE,
  is_write_mem_future_MEM,
  instruction_EXE,
  write_mem_data,
  ALU_result_MEM,
  rs1_address_ID,
  rs2_address_ID,
  rd_address_EXE,
  rs1_address_EXE,
  rs2_address_EXE,
  rs1_data_EXE,
  rs2_data_EXE,
  is_write_regs_future_EXE,
  is_B_immediate_EXE,
  immediate_EXE,
  is_branch_EXE,
  is_jal_EXE,
  is_jalr_EXE,
  is_lui_EXE,
  ALU_option_EXE,
  pc_MEM,
  instruction_MEM,
  is_write_regs_future_MEM,
  is_jal_MEM,
  is_jalr_MEM,
  pc_WB,
  rd_address_WB,
  is_write_regs,
  write_regs_data,
  flatten_registers,
  instruction_WB,
  rd_address_MEM
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, ASSOCIATED_BUSIF clk, FREQ_HZ 100000000, PHASE 0.000" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_HIGH" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire [31 : 0] instruction_IF;
input wire [31 : 0] mem_read_data_MEM;
output wire [31 : 0] pc_IF;
output wire [31 : 0] pc_ID;
output wire [31 : 0] instruction_ID;
output wire [31 : 0] pc_EXE;
output wire is_write_mem_future_EXE;
output wire is_write_mem_future_MEM;
output wire [31 : 0] instruction_EXE;
output wire [31 : 0] write_mem_data;
output wire [31 : 0] ALU_result_MEM;
output wire [4 : 0] rs1_address_ID;
output wire [4 : 0] rs2_address_ID;
output wire [4 : 0] rd_address_EXE;
output wire [4 : 0] rs1_address_EXE;
output wire [4 : 0] rs2_address_EXE;
output wire [31 : 0] rs1_data_EXE;
output wire [31 : 0] rs2_data_EXE;
output wire is_write_regs_future_EXE;
output wire is_B_immediate_EXE;
output wire [31 : 0] immediate_EXE;
output wire is_branch_EXE;
output wire is_jal_EXE;
output wire is_jalr_EXE;
output wire is_lui_EXE;
output wire [2 : 0] ALU_option_EXE;
output wire [31 : 0] pc_MEM;
output wire [31 : 0] instruction_MEM;
output wire is_write_regs_future_MEM;
output wire is_jal_MEM;
output wire is_jalr_MEM;
output wire [31 : 0] pc_WB;
output wire [4 : 0] rd_address_WB;
output wire is_write_regs;
output wire [31 : 0] write_regs_data;
output wire [991 : 0] flatten_registers;
output wire [31 : 0] instruction_WB;
output wire [4 : 0] rd_address_MEM;

  pipeline_CPU inst (
    .clk(clk),
    .rst(rst),
    .instruction_IF(instruction_IF),
    .mem_read_data_MEM(mem_read_data_MEM),
    .pc_IF(pc_IF),
    .pc_ID(pc_ID),
    .instruction_ID(instruction_ID),
    .pc_EXE(pc_EXE),
    .is_write_mem_future_EXE(is_write_mem_future_EXE),
    .is_write_mem_future_MEM(is_write_mem_future_MEM),
    .instruction_EXE(instruction_EXE),
    .write_mem_data(write_mem_data),
    .ALU_result_MEM(ALU_result_MEM),
    .rs1_address_ID(rs1_address_ID),
    .rs2_address_ID(rs2_address_ID),
    .rd_address_EXE(rd_address_EXE),
    .rs1_address_EXE(rs1_address_EXE),
    .rs2_address_EXE(rs2_address_EXE),
    .rs1_data_EXE(rs1_data_EXE),
    .rs2_data_EXE(rs2_data_EXE),
    .is_write_regs_future_EXE(is_write_regs_future_EXE),
    .is_B_immediate_EXE(is_B_immediate_EXE),
    .immediate_EXE(immediate_EXE),
    .is_branch_EXE(is_branch_EXE),
    .is_jal_EXE(is_jal_EXE),
    .is_jalr_EXE(is_jalr_EXE),
    .is_lui_EXE(is_lui_EXE),
    .ALU_option_EXE(ALU_option_EXE),
    .pc_MEM(pc_MEM),
    .instruction_MEM(instruction_MEM),
    .is_write_regs_future_MEM(is_write_regs_future_MEM),
    .is_jal_MEM(is_jal_MEM),
    .is_jalr_MEM(is_jalr_MEM),
    .pc_WB(pc_WB),
    .rd_address_WB(rd_address_WB),
    .is_write_regs(is_write_regs),
    .write_regs_data(write_regs_data),
    .flatten_registers(flatten_registers),
    .instruction_WB(instruction_WB),
    .rd_address_MEM(rd_address_MEM)
  );
endmodule
