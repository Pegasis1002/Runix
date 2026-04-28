# Define our toolchain and flags as variables so we can easily change them
CC = riscv32-none-elf-gcc
LD = riscv32-none-elf-ld
CFLAGS = -march=rv32im_zicsr -mabi=ilp32 -mcmodel=medany -ffreestanding -O0

SRC_DIR = src
BUILD_DIR = build

TARGET_ELF = $(BUILD_DIR)/runix.elf
OBJS = $(BUILD_DIR)/boot.o $(BUILD_DIR)/main.o


# 'all' is the default target when you just type 'make'
all: $(TARGET_ELF)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# How to build the final ELF. 
# $^ means "all prerequisites" (the .o files)
# $@ means "the target" (the .elf file)
$(TARGET_ELF): $(OBJS) | $(BUILD_DIR)
	$(LD) -T linker.ld $^ -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.s | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Pattern rule: How to build ANY .o file from a .c file in the src dir
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# A utility command to delete compiled files
clean:
	rm -rf $(BUILD_DIR)

# Change the path to wherever your emulator is
run: $(TARGET_ELF)
	../Iron-clad/target/debug/iron-clad runix.elf

.PHONY: all clean run
