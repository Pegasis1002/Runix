#include<stdint.h>
#include "io/uart.h"
#include "csr/m_csr.h"
#include "interrupts/interrupts.h"

#define MTIMECMP_L (*(volatile uint32_t*) 0x02004000)
#define MTIMECMP_H (*(volatile uint32_t*) 0x02004004)

// Entry point
void kmain (void) {
    write_mtvec((uint32_t)handle_trap);

    uint32_t mstatus_val = read_mstatus();
    write_mstatus(mstatus_val | (1 << 3));

    write_mie(1 << 7);

    for (int i = 0; i < 341; i++) {
        VRAM[i] = 0xFFFF0000;
    }

    print_char('X');
    print_char('\n');

    MTIMECMP_L = 100000; 
    MTIMECMP_H = 0;

    print_str("Hello, World!\n");

    while(1) {}
}
