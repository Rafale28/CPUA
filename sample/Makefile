SRCDIR=.
ASMDIR=$(SRCDIR)/../assembler/obj
CPUDIR=$(SRCDIR)/../DE0_CV/
ASM=$(ASMDIR)/assembler
%.run:
	cd $(CPUDIR);make CPUA.vsim

%.sim: %.hex
	cp $*.hex $(CPUDIR)/program.hex
	cd $(CPUDIR);make CPUA.vsim

%.hex: %.asm
	$(ASM) $*.asm

clean:
	-rm *.hex
	cd $(CPUDIR);rm program.hex
	cd $(CPUDIR);make clean
