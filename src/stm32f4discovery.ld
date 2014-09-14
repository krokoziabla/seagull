ENTRY(reset)

MEMORY
{
    ram : ORIGIN = 0x20000000, LENGTH = 0x30000
    rom : ORIGIN = 0x08000000, LENGTH = 0x100000
}

SECTIONS
{
    .text : { *(.text) } > ram
    .data : { *(.data) } > ram
    .bss : { *(.bss) } > ram
}
