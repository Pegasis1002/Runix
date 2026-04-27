ENTRY(_start)

SECTIONS
{
    /* We tell the linker our RAM starts here */
    . = 0x80000000;

    /* Force the boot assembly to be at the absolute front */
    .text : ALIGN(4) {
        *(.text.boot)
        *(.text)
    }

    .rodata : ALIGN(4) {
        *(.rodata)
    }

    .data : ALIGN(4) {
        *(.data)
    }

    .bss : ALIGN(4) {
        *(.bss)
    }
}
