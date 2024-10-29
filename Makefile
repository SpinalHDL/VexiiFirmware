# When you change the memory size below, make sure to also change it in:
#
# ./sw/default.ld
# ./sw/start.S
# ./rtl/top.v

MEM_WORDS       = 1024
MEM_BYTES       = 4096

MARCH           = rv32ic
CPU_FREQ_MHZ    = 50
CC_OPT          = -Os

OBJ_FILES       = start.o main.o lib.o trap.o

OPENOCD         ?= /usr/local/bin/openocd

#TARGET          = riscv32-unknown-elf
TARGET          = riscv64-none-elf

AS              = $(TARGET)-as
ASFLAGS         = -march=$(MARCH) -mabi=ilp32
LD              = $(TARGET)-gcc
LDFLAGS         = -march=$(MARCH) -g -ggdb -mabi=ilp32 -Wl,-Tdefault.ld,-Map,progmem.map -ffreestanding -nostartfiles -Wl,--no-relax -Wl,--start-group,--end-group
CC              = $(TARGET)-gcc
CFLAGS          = -march=$(MARCH) -g -ggdb -mno-div -mabi=ilp32 -ffunction-sections -fdata-sections -Wall -Wextra -pedantic -DCPU_FREQ=$(CPU_FREQ_MHZ)000000 $(CC_OPT)
OBJCOPY         = $(TARGET)-objcopy
OBJDUMP         = $(TARGET)-objdump
READELF         = $(TARGET)-readelf

CREATE_MIF      = ../misc/create_mif.rb

.PHONY: all clean

all: progmem.dis progmem.bin progmem0.hex progmem0.mif

progmem.dis: progmem_dis.elf
	$(OBJDUMP) -s -D $< > $@

progmem0.hex: progmem.bin
	$(CREATE_MIF) -f hex -d $(MEM_WORDS) -w 8 -o 0 -i 4 $< > progmem0.hex
	$(CREATE_MIF) -f hex -d $(MEM_WORDS) -w 8 -o 1 -i 4 $< > progmem1.hex
	$(CREATE_MIF) -f hex -d $(MEM_WORDS) -w 8 -o 2 -i 4 $< > progmem2.hex
	$(CREATE_MIF) -f hex -d $(MEM_WORDS) -w 8 -o 3 -i 4 $< > progmem3.hex

progmem0.mif: progmem.bin
	$(CREATE_MIF) -f mif -d $(MEM_WORDS) -w 8 -o 0 -i 4 $< > progmem0.mif
	$(CREATE_MIF) -f mif -d $(MEM_WORDS) -w 8 -o 1 -i 4 $< > progmem1.mif
	$(CREATE_MIF) -f mif -d $(MEM_WORDS) -w 8 -o 2 -i 4 $< > progmem2.mif
	$(CREATE_MIF) -f mif -d $(MEM_WORDS) -w 8 -o 3 -i 4 $< > progmem3.mif

progmem.bin: progmem.elf
	$(OBJCOPY) -O binary $< $@

progmem.elf: $(OBJ_FILES) top_defines.h default.ld Makefile
	$(LD) $(LDFLAGS) -o $@ $(OBJ_FILES) -lm

progmem_dis.elf: $(OBJ_FILES) top_defines.h default.ld Makefile
	$(LD) $(LDFLAGS) -o $@ $(OBJ_FILES) -lm

main.o: top_defines.h

main.c: top_defines.h

ocd_only:
	$(OPENOCD) -f interface/ftdi/digilent_jtag_smt2.cfg \
		-c "adapter speed 1000; transport select jtag" \
		-f "vexriscv_init.cfg"

ocd_only_sim:
	$(OPENOCD) \
		-c "adapter driver jtag_tcp; adapter speed 1000; transport select jtag" \
		-f "vexriscv_init.cfg"

gdb_only:
	$(TARGET)-gdb -q \
		progmem.elf \
		-ex "target extended-remote localhost:3333"

gdb:
	OPENOCD_DIR=$(OPENOCD_DIR) $(TARGET)-gdb -q \
		progmem.elf \
		-x ./gdb_ocd_open.cmd

clean:
	\rm -fr *.o *.hex *.elf *.dis *.bin *.coe *.map *.mif *.mem *.funcs *.globs
