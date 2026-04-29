#pragma once
# include <stdint.h>

#define UART_ADDR 0x10000000
#define VRAM_ADDR 0x11000000

#define UART (*(volatile uint32_t*) UART_ADDR)
#define VRAM ((volatile uint32_t*) VRAM_ADDR)

void print_char(char c);
void print_str(const char* str);
