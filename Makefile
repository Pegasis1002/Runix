# --- Toolchain ---
CC = riscv32-none-elf-gcc
LD = riscv32-none-elf-ld

# Include the src directory so #include "interrupts/interrupts.h" works
INC_FLAGS = -Isrc
# -MMD -MP are the magic flags that tell GCC to track .h file dependencies automatically
CFLAGS = -march=rv32im_zicsr -mabi=ilp32 -mcmodel=medany -ffreestanding -O0 $(INC_FLAGS) -MMD -MP

# --- Directories ---
SRC_DIR = src
BUILD_DIR = build

# --- Auto-Discovery ---
# Find all .c and .s files inside src/ and its subdirectories
C_SRCS := $(shell find $(SRC_DIR) -name '*.c')
ASM_SRCS := $(shell find $(SRC_DIR) -name '*.s')

# Replace "src/..." with "build/..." and ".c/.s" with ".o"
C_OBJS := $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(C_SRCS))
ASM_OBJS := $(patsubst $(SRC_DIR)/%.s, $(BUILD_DIR)/%.o, $(ASM_SRCS))

# Combine them into one list of objects
OBJS := $(C_OBJS) $(ASM_OBJS)

# Generate a list of dependency files (.d) created by GCC
DEPS := $(OBJS:.o=.d)

TARGET_ELF = $(BUILD_DIR)/runix.elf

# --- Rules ---
all: $(TARGET_ELF)

$(TARGET_ELF): $(OBJS)
	@mkdir -p $(dir $@)
	$(LD) -T linker.ld $^ -o $@

# How to compile C files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# How to compile Assembly files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR)

run: $(TARGET_ELF)
	../Iron-clad/target/debug/iron-clad $(TARGET_ELF)

.PHONY: all clean run

# Include the auto-generated dependency files
-include $(DEPS)
