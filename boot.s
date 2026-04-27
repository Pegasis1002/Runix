.section .text.boot
.global _start

_start:
    la sp, 0x88000000
    call kmain

halt:
    j halt
