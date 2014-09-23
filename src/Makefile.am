bin_PROGRAMS = seagull

AM_CCASFLAGS = -mtune=cortex-m4 -ggdb -O0

AM_LDFLAGS = -T $(srcdir)/stm32f4discovery.ld -nostartfiles

seagull_SOURCES = 	exceptions.s \
					startup.s \
					vectors.s \
					$(NULL)
