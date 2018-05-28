ENTRY(__reset_vector)

MEMORY
{
    code (rx) : ORIGIN = 0x00000000, LENGTH = 0x20000000 /* mapped either on sram or flash or system memory */
    sram :      ORIGIN = 0x20000000, LENGTH = 0x30000
    flash :     ORIGIN = 0x08000000, LENGTH = 0x100000
}

SECTIONS
{
    vectors :
    {
        LONG(__system_stack);
        LONG(__reset_vector + 1);
        LONG(0);
        LONG(__hard_fault_vector + 1);
    } > code AT > sram

    .text : { *(.text) } > code AT > sram

    .data : { *(.data) } > sram

    .bss :
    {
        . = . + 0x1000;             /* reserve 4 KiB for system stack */
        __system_stack = . ;
        *(.bss)
    } > sram
}
