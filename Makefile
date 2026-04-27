# Define our toolchain and flags as variables so we can easily change them
CC = riscv32-none-elf-gcc
LD = riscv32-none-elf-ld
CFLAGS = -march=rv32im -mabi=ilp32 -mcmodel=medany -ffreestanding -O0

# 'all' is the default target when you just type 'make'
all: runix.elf

# How to build the final ELF. It depends on boot.o and main.o
runix.elf: boot.o main.o
	$(LD) -T linker.ld boot.o main.o -o runix.elf

# How to build boot.o. It depends on boot.s
boot.o: boot.s
	$(CC) $(CFLAGS) -c boot.s -o boot.o

# How to build main.o. It depends on main.c
main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

# A utility command to delete compiled files
clean:
	rm -f *.o *.elf *.bin

# Change the path to wherever your emulator is
run: runix.elf
	../Iron-clad/target/debug/iron-clad runix.elf
