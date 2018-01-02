################################################################################
# Makefile : sof file generation using Quartus II
# Usage:
#		make compile for synthesis all files
#       make download for download .sof file to FPGA board
################################################################################
# 2014.07.22 Initial version by T.Furukawa (based on AISoC's makefile)
################################################################################

ifndef SRCDIR
SRCDIR	= .
endif
WORKDIR		= $(SRCDIR)/work
DEBUGDIR	= $(SRCDIR)/debug
VPATH		= $(SRCDIR):$(SRCDIR)/HEX:$(SRCDIR)/MEM:$(SRCDIR)/CPU
ifndef DESIGN
DESIGN		= DE0_CV
endif
TARGET		=
PROJECT		= $(DESIGN)
NSL2VL    	= nsl2vl
NSLSIMFLAGS = -sim -neg_res -I$(SRCDIR)
ifndef SIM
NSLFLAGS  	= -O2 -neg_res -I$(SRCDIR) -I$(SRCDIR)/HEX -I$(SRCDIR)/MEM -I$(SRCDIR)/CPU
else
NSLFLAGS	= $(NSLSIMFLAGS)
endif
MKPROJ		= $(SRCDIR)/mkproj-$(DESIGN).tcl
LBITS		= $(shell getconf LONG_BIT)
ifeq	($(LBITS),64)
	Q2SH		= quartus_sh --64bit
	Q2PGM		= quartus_pgm --64bit
else
	Q2SH		= quartus_sh 
	Q2PGM		= quartus_pgm 
endif
Q2SHOPT		= -fit "fast fit"

CABLE		= "USB-Blaster"
PMODE		= JTAG

VERIOPT		= 
SRCS		=  HEX.nsl CPUA.nsl LED.nsl SWI.nsl HEXD.nsl 
SYNTHSRCS	= $(PROJECT).nsl $(SRCS)
VFILES 		= $(SYNTHSRCS:%.nsl=%.v) 
SIMVFILES	= $(SRCS:%.nsl=%.v)
LIBS		= imem.v 
RESULT		= result.txt

##################################################################################
#quartus
##################################################################################

all:
	@if [ ! -d $(WORKDIR) ]; then \
		echo mkdir $(WORKDIR); \
		mkdir $(WORKDIR); \
	fi
	( cd $(WORKDIR); make -f ../Makefile SRCDIR=.. compile )

########

.SUFFIXES: .v .nsl

%.v:%.nsl
	$(NSL2VL) $(NSLFLAGS) $< -o $@

$(PROJECT).qsf: $(VFILES) $(LIBS) 
	$(Q2SH) -t $(MKPROJ) $(Q2SHOPT) -project $(PROJECT) $^

$(PROJECT).sof: $(PROJECT).qsf 
	$(Q2SH) --flow compile $(PROJECT)

########

compile: $(PROJECT).sof
	@echo "**** $(PROJECT).fit.summary" | tee -a $(RESULT)
	@cat $(PROJECT).fit.summary | tee -a $(RESULT)
	@echo "**** $(PROJECT).tan.rpt" | tee -a $(RESULT)
#	@grep "Info: Fmax" $(PROJECT).tan.rpt | tee -a $(RESULT)

download: config-n

config: all
	$(Q2PGM) -c $(CABLE) -m $(PMODE) -o "p;$(WORKDIR)/$(PROJECT).sof"
config-n: # without re-compile
	$(Q2PGM) -c $(CABLE) -m $(PMODE) -o "p;$(WORKDIR)/$(PROJECT).sof"
	
%.write:
	quartus_stp -t ./mem_write imem $*.mif 

##################################################################################
#verilator
##################################################################################

%.sim:
	@if [ ! -d $(DEBUGDIR) ]; then \
		echo mkdir $(DEBUGDIR); \
		mkdir $(DEBUGDIR); \
	fi
	( cd $(DEBUGDIR); make -f ../Makefile SRCDIR=.. TARGET=$(@:%.sim=%) V$(@:%.sim=%) )

V$(TARGET).h: $(VFILES) $(TARGET)_sim.cpp
	sed -i -e "s/#1//" *.v
	verilator --cc $(VERIOPT) $(TARGET).v --exe $(SRCDIR)/$(TARGET)_sim.cpp

V$(TARGET): V$(TARGET).h 
	@echo "simulation"
	(cd obj_dir; make -j -f V$(TARGET).mk V$(TARGET) )

%.run:%.sim
	(time $(DEBUGDIR)/obj_dir/V$(@:%.run=%))

%.rerun:
	(time $(DEBUGDIR)/obj_dir/V$(@:%.rerun=%))


##################################################################################
#iverilog
##################################################################################

%_sim.v: %_sim.nsl
	$(NSL2VL) $(NSLSIMFLAGS) -verisim2 -target $(@:%.v=%) $< -o $@

%.vsim:
	@if [ ! -d $(DEBUGDIR) ]; then \
		echo mkdir $(DEBUGDIR); \
		mkdir $(DEBUGDIR); \
	fi
	( cd $(DEBUGDIR); make -f ../Makefile SIM=1 SRCDIR=.. TARGET=$* gtkwave )

$(TARGET).vvp: $(TARGET)_sim.v $(SIMVFILES)
	iverilog -o $@ $^

$(TARGET)_sim.vcd: $(TARGET).vvp program.hex
	vvp $<

gtkwave:$(TARGET)_sim.vcd
	gtkwave $< $(SRCDIR)/CPU/sim.sig





clean:
	rm -rf - $(WORKDIR)
	rm -rf - $(DEBUGDIR)

##################################################################################

