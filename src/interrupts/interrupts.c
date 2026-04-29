#include<stdint.h>
#include "csr/m_csr.h"
#include "io/uart.h"

__attribute__((interrupt("machine")))
void handle_trap(void) {
    uint32_t cause = read_mcause();

    print_str("INTERRUPT: Trap Caught!\n");
    write_mie(0);
}
