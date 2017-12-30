SRCDIR=.
ASMDIR=$(SRCDIR)/../assembler/obj
CPUDIR=$(SRCDIR)/../DE0_CV/
ASM=$(ASMDIR)/assembler
%.sim:
	$(ASM) $*.asm
	cp dump.hex $(CPUDIR)/program.hex
	cd $(CPUDIR);make CPUA.vsim

clean:
	rm dump.hex
	cd $(CPUDIR);rm program.hex
	cd $(CPUDIR);make clean
