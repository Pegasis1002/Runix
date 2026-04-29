#pragma once 
#include <stdint.h>

// Write to MTVEC
static inline void write_mtvec(uint32_t val) {
    __asm__ volatile ("csrw mtvec, %0" : : "r" (val));
}

// Write to MSTATUS
static inline void write_mstatus(uint32_t val) {
    __asm__ volatile ("csrw mstatus, %0" : : "r" (val));
}

// Read from MSTATUS
static inline uint32_t read_mstatus(void) {
    uint32_t val;
    __asm__ volatile ("csrr %0, mstatus" : "=r" (val));
    return val;
}

// Write to MIE
static inline void write_mie(uint32_t val) {
    __asm__ volatile ("csrw mie, %0" : : "r" (val));
}

// Read from MCAUSE
static inline uint32_t read_mcause(void) {
    uint32_t val;
    __asm__ volatile ("csrr %0, mcause" : "=r" (val));
    return val;
}
