###################################################################################################
# File Name : Makefile
# Description : Makefile to run test bench on FIFO 
# Author : Haroon Ahmed
# Created on : 15 Feb, 2022
# Last Updated : 15 Feb, 2022
# Version : 1
###################################################################################################


# Directories
#PROJ_DIR := $(TC_ROOT)/fifo_proj
DESIGN_DIR  := ../design/rtl
BENCH_DIR   := ../bench
INCLUDE_DIR := ../include
LIB_DIR     := ../lib
#TEST_DIR := $(VERIF_DIR)/test
# Tool
TOOL := vcs
GUI := 0

# VCS
ifeq ($(TOOL), vcs)
BLD_CMD  := vcs
BLD_OPTS := -sverilog
BLD_OPTS += -work library
BLD_OPTS += -full64 +vcs+vcdpluson
BLD_OPTS += -debug_acc+all
BLD_OPTS += +incdir+$(INCLUDE_DIR)
BLD_OPTS += -y $(LIB_DIR)/ +libext+.v
#BLD_OPTS += +lint=all
BLD_OPTS += +v2k
#BLD_OPTS += -work xil_defaultlib
BLD_OPTS += -l compile.log
#BLD_OPTS += -f $(LIB_DIR)/flist.f

SIM_CMD := ./simv -l simulation.log
ifeq ($(GUI), 1)
SIM_OPTS := -gui -dve_opt -session=session.inter.vpd.tcl -dve_opt -cmd='run'  
endif
else
# If no tool is selected
NO_TOOL_SEL := "Please Enter Valid Compilation Tool Name"
endif




# Design Files
DESIGN_FILES := $(DESIGN_DIR)/top_sync_fifo.v


#Bench Files
BENCH_FILES := $(BENCH_DIR)/tb_sync_fifo.sv



# Target
run_test: clean info compile sim



# Rules
compile:
# Compiling the Design
	$(BLD_CMD) $(BLD_OPTS) $(DESIGN_FILES) $(BENCH_FILES) | tee -a compile.log
sim:
# Simulating the Design
	$(SIM_CMD) $(SIM_OPTS) | tee -a simulate.log
# Information about the design and tool
info:
	@echo "**********************************************"
	@echo "This is the Makefile for Half Adder Design"
	@echo " "
	@echo "The design adds two 1-bit numbers"
	@echo " "
	@echo "Tool: $(TOOL)"
	@echo "**********************************************"
	@echo $(NO_TOOL_SEL)
clean:
# Cleaning the Test Directory
	@rm -rf "simv"
	@rm -rf "csrc"
	@rm -rf "DVEfiles"
	@rm -rf "simv.daidir"
	@rm -rf "ucli.key"
	@rm -rf "inter.vpd"

	#To open the vpd/dump/wave file run the followinf commnand
	#dve -vpd inter.vpd -session session.inter.vpd.tcl
