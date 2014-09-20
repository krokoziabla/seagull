ENTRY(__reset_vector)

MEMORY
{
    ram : ORIGIN = 0x20000000, LENGTH = 0x30000
    rom : ORIGIN = 0x08000000, LENGTH = 0x100000
}

SECTIONS
{
    vectors : { seagull-vectors.o(vectors) } > ram

    .text : { *(.text) } > ram
    .data : { *(.data) } > ram
    .bss : { *(.bss) } > ram
}

/* __startup_stack = 0x2000 + 0x1000;         /* 4 kB stack */
