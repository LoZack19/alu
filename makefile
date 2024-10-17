# GHDL Makefile for VHDL compilation and simulation

# GHDL command
GHDL = ghdl

# VHDL source files
SRCS = src/full_adder.vhd src/testbench.vhd

# Default target
all: run

# Top-level entity for simulation
TOP_LEVEL = testbench

# Work library
WORK = work

# Analyze target
analyze: $(SRCS)
	$(GHDL) -a --workdir=$(WORK) $(SRCS)

# Elaborate target
elaborate: analyze
	$(GHDL) -e --workdir=$(WORK) $(TOP_LEVEL)

# Run target
run: elaborate
	$(GHDL) -r --workdir=$(WORK) $(TOP_LEVEL) --wave=$(TOP_LEVEL).ghw

simulate: run
	gtkwave $(TOP_LEVEL).ghw

# Clean target
clean:
	$(GHDL) --clean
	rm -rf $(WORK)/*
	rm -f *.o *.cf *.ghw

.PHONY: analyze elaborate run clean all