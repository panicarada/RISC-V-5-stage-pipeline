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


// IP VLNV: xilinx.com:user:VGA:1.0
// IP Revision: 5

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module CSSTE_VGA_0_0 (
  clk_25m,
  clk_100m,
  rst,
  pc_IF,
  inst_IF,
  pc_ID,
  inst_ID,
  pc_EXE,
  MemRW_Ex,
  MemRW_Mem,
  write_mem_data,
  ALU_result_MEM,
  rd_address_EXE,
  rs1_address_EXE,
  rs2_address_EXE,
  rs1_data_EXE,
  rs2_data_EXE,
  is_write_regs_future_EXE,
  is_B_immediate_EXE,
  instruction_EXE,
  immediate_EXE,
  is_branch_EXE,
  is_jal_EXE,
  is_jalr_EXE,
  is_lui_EXE,
  ALU_option_EXE,
  pc_MEM,
  instruction_MEM,
  rd_address_MEM,
  is_write_regs_future_MEM,
  is_jal_MEM,
  is_jalr_MEM,
  pc_WB,
  instruction_WB,
  rd_address_WB,
  is_write_regs,
  write_regs_data,
  flatten_registers,
  hs,
  vs,
  vga_r,
  vga_g,
  vga_b
);

input wire clk_25m;
input wire clk_100m;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_HIGH" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire [31 : 0] pc_IF;
input wire [31 : 0] inst_IF;
input wire [31 : 0] pc_ID;
input wire [31 : 0] inst_ID;
input wire [31 : 0] pc_EXE;
input wire MemRW_Ex;
input wire MemRW_Mem;
input wire [31 : 0] write_mem_data;
input wire [31 : 0] ALU_result_MEM;
input wire [4 : 0] rd_address_EXE;
input wire [4 : 0] rs1_address_EXE;
input wire [4 : 0] rs2_address_EXE;
input wire [31 : 0] rs1_data_EXE;
input wire [31 : 0] rs2_data_EXE;
input wire is_write_regs_future_EXE;
input wire is_B_immediate_EXE;
input wire [31 : 0] instruction_EXE;
input wire [31 : 0] immediate_EXE;
input wire is_branch_EXE;
input wire is_jal_EXE;
input wire is_jalr_EXE;
input wire is_lui_EXE;
input wire [2 : 0] ALU_option_EXE;
input wire [31 : 0] pc_MEM;
input wire [31 : 0] instruction_MEM;
input wire [4 : 0] rd_address_MEM;
input wire is_write_regs_future_MEM;
input wire is_jal_MEM;
input wire is_jalr_MEM;
input wire [31 : 0] pc_WB;
input wire [31 : 0] instruction_WB;
input wire [4 : 0] rd_address_WB;
input wire is_write_regs;
input wire [31 : 0] write_regs_data;
input wire [991 : 0] flatten_registers;
output wire hs;
output wire vs;
output wire [3 : 0] vga_r;
output wire [3 : 0] vga_g;
output wire [3 : 0] vga_b;

  VGA inst (
    .clk_25m(clk_25m),
    .clk_100m(clk_100m),
    .rst(rst),
    .pc_IF(pc_IF),
    .inst_IF(inst_IF),
    .pc_ID(pc_ID),
    .inst_ID(inst_ID),
    .pc_EXE(pc_EXE),
    .MemRW_Ex(MemRW_Ex),
    .MemRW_Mem(MemRW_Mem),
    .write_mem_data(write_mem_data),
    .ALU_result_MEM(ALU_result_MEM),
    .rd_address_EXE(rd_address_EXE),
    .rs1_address_EXE(rs1_address_EXE),
    .rs2_address_EXE(rs2_address_EXE),
    .rs1_data_EXE(rs1_data_EXE),
    .rs2_data_EXE(rs2_data_EXE),
    .is_write_regs_future_EXE(is_write_regs_future_EXE),
    .is_B_immediate_EXE(is_B_immediate_EXE),
    .instruction_EXE(instruction_EXE),
    .immediate_EXE(immediate_EXE),
    .is_branch_EXE(is_branch_EXE),
    .is_jal_EXE(is_jal_EXE),
    .is_jalr_EXE(is_jalr_EXE),
    .is_lui_EXE(is_lui_EXE),
    .ALU_option_EXE(ALU_option_EXE),
    .pc_MEM(pc_MEM),
    .instruction_MEM(instruction_MEM),
    .rd_address_MEM(rd_address_MEM),
    .is_write_regs_future_MEM(is_write_regs_future_MEM),
    .is_jal_MEM(is_jal_MEM),
    .is_jalr_MEM(is_jalr_MEM),
    .pc_WB(pc_WB),
    .instruction_WB(instruction_WB),
    .rd_address_WB(rd_address_WB),
    .is_write_regs(is_write_regs),
    .write_regs_data(write_regs_data),
    .flatten_registers(flatten_registers),
    .hs(hs),
    .vs(vs),
    .vga_r(vga_r),
    .vga_g(vga_g),
    .vga_b(vga_b)
  );
endmodule
