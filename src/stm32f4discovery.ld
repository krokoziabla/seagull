ENTRY(__reset_vector)

MEMORY
{
    code (rx) : ORIGIN = 0x00000000, LENGTH = 0x20000000 /* mapped either on sram or flash or system memory */
    sram :      ORIGIN = 0x20000000, LENGTH = 0x30000
    flash :     ORIGIN = 0x08000000, LENGTH = 0x100000
}

SECTIONS
{
    vectors : { vectors.o(vectors) } > code AT > sram

    .text : { *(.text) } > code AT > sram

    .data :
    {
        . = . + 0x1000;             /* reserve 4 KiB for system stack */
        __system_stack = . ;
        *(.data)
    } > sram

    .bss : { *(.bss) } > sram
}
