ENTRY(__reset_vector)

MEMORY
{
    sram : ORIGIN = 0x20000000, LENGTH = 0x30000
    flash : ORIGIN = 0x08000000, LENGTH = 0x100000
}

SECTIONS
{
    vectors : { seagull-vectors.o(vectors) } > sram

    .text : { *(.text) } > sram

    .data :
    {
        . = . + 0x1000;             /* reserve 4 KiB for system stack */
        __system_stack = . ;
        *(.data)
    } > sram

    .bss : { *(.bss) } > sram
}
