vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xlslice_v1_0_1
vlib modelsim_lib/msim/dist_mem_gen_v8_0_12
vlib modelsim_lib/msim/util_vector_logic_v2_0_1
vlib modelsim_lib/msim/xlconcat_v2_1_1
vlib modelsim_lib/msim/xlconstant_v1_1_3
vlib modelsim_lib/msim/blk_mem_gen_v8_4_1

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm
vmap xlslice_v1_0_1 modelsim_lib/msim/xlslice_v1_0_1
vmap dist_mem_gen_v8_0_12 modelsim_lib/msim/dist_mem_gen_v8_0_12
vmap util_vector_logic_v2_0_1 modelsim_lib/msim/util_vector_logic_v2_0_1
vmap xlconcat_v2_1_1 modelsim_lib/msim/xlconcat_v2_1_1
vmap xlconstant_v1_1_3 modelsim_lib/msim/xlconstant_v1_1_3
vmap blk_mem_gen_v8_4_1 modelsim_lib/msim/blk_mem_gen_v8_4_1

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"C:/XilinxV2017/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"C:/XilinxV2017/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xlslice_v1_0_1 -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/f3db/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../bd/CSSTE/ip/CSSTE_xlslice_0_0/sim/CSSTE_xlslice_0_0.v" \
"../../../bd/CSSTE/ip/CSSTE_xlslice_0_1/sim/CSSTE_xlslice_0_1.v" \
"../../../bd/CSSTE/ip/CSSTE_xlslice_0_2/sim/CSSTE_xlslice_0_2.v" \
"../../../bd/CSSTE/ipshared/d063/sources_1/new/clk_div.v" \
"../../../bd/CSSTE/ip/CSSTE_clk_div_0_0/sim/CSSTE_clk_div_0_0.v" \
"../../../bd/CSSTE/ip/CSSTE_BTN_OK0_0/sim/CSSTE_BTN_OK0_0.v" \

vlog -work dist_mem_gen_v8_0_12 -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/d46a/simulation/dist_mem_gen_v8_0.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../bd/CSSTE/ip/CSSTE_dist_mem_gen_0_0/sim/CSSTE_dist_mem_gen_0_0.v" \

vlog -work util_vector_logic_v2_0_1 -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../bd/CSSTE/ip/CSSTE_util_vector_logic_0_0/sim/CSSTE_util_vector_logic_0_0.v" \
"../../../bd/CSSTE/ip/CSSTE_util_vector_logic_0_1/sim/CSSTE_util_vector_logic_0_1.v" \
"../../../bd/CSSTE/ip/CSSTE_SW8_0/sim/CSSTE_SW8_0.v" \
"../../../bd/CSSTE/ip/CSSTE_SW8_1/sim/CSSTE_SW8_1.v" \
"../../../bd/CSSTE/ip/CSSTE_SW8_2/sim/CSSTE_SW8_2.v" \

vlog -work xlconcat_v2_1_1 -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/2f66/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../bd/CSSTE/ip/CSSTE_xlconcat_0_0/sim/CSSTE_xlconcat_0_0.v" \
"../../../bd/CSSTE/ip/CSSTE_xlslice_0_3/sim/CSSTE_xlslice_0_3.v" \
"../../../bd/CSSTE/ip/CSSTE_div20_0/sim/CSSTE_div20_0.v" \

vlog -work xlconstant_v1_1_3 -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/0750/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../bd/CSSTE/ip/CSSTE_xlconstant_0_0/sim/CSSTE_xlconstant_0_0.v" \
"../../../bd/CSSTE/ip/CSSTE_xlconcat_1_0/sim/CSSTE_xlconcat_1_0.v" \
"../../../bd/CSSTE/ip/CSSTE_xlslice_0_4/sim/CSSTE_xlslice_0_4.v" \
"../../../bd/CSSTE/ip/CSSTE_xlconstant_0_1/sim/CSSTE_xlconstant_0_1.v" \
"../../../bd/CSSTE/ip/CSSTE_xlslice_0_5/sim/CSSTE_xlslice_0_5.v" \
"../../../bd/CSSTE/ip/CSSTE_xlslice_0_6/sim/CSSTE_xlslice_0_6.v" \
"../../../bd/CSSTE/ip/CSSTE_xlslice_0_7/sim/CSSTE_xlslice_0_7.v" \
"../../../bd/CSSTE/ipshared/67de/HexTo8SEG.v" \
"../../../bd/CSSTE/ipshared/67de/MC14495_ZJU.v" \
"../../../bd/CSSTE/ipshared/67de/MUX2T1_64.v" \
"../../../bd/CSSTE/ipshared/67de/P2S.v" \
"../../../bd/CSSTE/ipshared/67de/SSeg_map.v" \
"../../../bd/CSSTE/ipshared/67de/SSeg7_Dev.v" \
"../../../bd/CSSTE/ip/CSSTE_SSeg7_Dev_0_0/sim/CSSTE_SSeg7_Dev_0_0.v" \

vlog -work blk_mem_gen_v8_4_1 -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ip/CSSTE_RAM_B_0_0/RAM_B.srcs/sources_1/ip/RAM/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" "+incdir+../../../bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/768c" "+incdir+../../../../../../05_04/pipeline_stall/pipeline_stall.srcs/sources_1/bd/CSSTE/ipshared/22f1/imports/Framework" \
"../../../bd/CSSTE/ip/CSSTE_RAM_B_0_0/RAM_B.srcs/sources_1/ip/RAM/sim/RAM.v" \
"../../../bd/CSSTE/ipshared/cc35/RAM_B.srcs/sources_1/new/RAM_B.v" \
"../../../bd/CSSTE/ip/CSSTE_RAM_B_0_0/sim/CSSTE_RAM_B_0_0.v" \
"../../../bd/CSSTE/ipshared/768c/pipeline_CPU.v" \
"../../../bd/CSSTE/ip/CSSTE_pipeline_CPU_0_0/sim/CSSTE_pipeline_CPU_0_0.v" \
"../../../bd/CSSTE/ipshared/22f1/imports/Framework/VgaController.v" \
"../../../bd/CSSTE/ipshared/22f1/imports/Framework/VgaDebugger.v" \
"../../../bd/CSSTE/ipshared/22f1/imports/Framework/VgaDisplay.v" \
"../../../bd/CSSTE/ipshared/22f1/imports/Framework/VGA.v" \
"../../../bd/CSSTE/ip/CSSTE_VGA_0_0/sim/CSSTE_VGA_0_0.v" \
"../../../bd/CSSTE/sim/CSSTE.v" \

vlog -work xil_defaultlib \
"glbl.v"

