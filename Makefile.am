bin_PROGRAMS = seagull

seagull_CCASFLAGS = -mtune=cortex-m4

seagull_LDFLAGS = -T $(srcdir)/src/stm32f4discovery.ld -nostartfiles

seagull_SOURCES = src/exceptions.s src/startup.s src/vectors.s
