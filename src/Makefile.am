bin_PROGRAMS = seagull

AM_CCASFLAGS = -mtune=cortex-m4 -ggdb -O0

AM_LDFLAGS = -T $(srcdir)/stm32f4discovery.ld -nostartfiles -nostdlib -nodefaultlibs -no-pie

seagull_SOURCES = 	exceptions.s \
					startup.s \
					vectors.s \
					$(NULL)

seagull_DEPENDENCIES = stm32f4discovery.ld Makefile.am
