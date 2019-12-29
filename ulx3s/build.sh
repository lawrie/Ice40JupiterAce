#!/bin/bash

DEVICE=25k
PIN_DEF=ulx3s_v20.lpf
IDCODE=0x21111043 # 12f
PACKAGE=CABGA381
TOP=jupiter_ace
NAME=jupiter_ace
SRCS="../src/fpga_ace.v ../src/relojes_ecp5.v ../src/jace_logic.v ../src/jupiter_ace_ulx3s.v ../src/keyboard_for_ace.v ../src/memorias.v ../src/ps2_port.v ../src/tv80_alu.v ../src/tv80_core.v ../src/tv80_mcode.v ../src/tv80n.v ../src/tv80_reg.v ../src/vga_scandoubler.v"

yosys -q -f "verilog -Duse_sb_io" -l ${NAME}.log -p "synth_ecp5 -top ${TOP} -abc2 -json ${NAME}.json" ${SRCS}
nextpnr-ecp5 --${DEVICE} --package ${PACKAGE} --lpf ${PIN_DEF} --json ${NAME}.json --textcfg ${NAME}.config
ecppack --idcode ${IDCODE} ${NAME}.config ${NAME}.bit
