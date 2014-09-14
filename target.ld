MEMORY
{
    ram : ORIGIN = 0x20000000, LENGTH = 0x30000
}

SECTIONS
{
    .text : { *(.text) } > ram
    .data : { *(.data) }
    .bss : { *(.bss) }
}
