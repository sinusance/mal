# The name of the source files
SRCS = step0_repl.c 
OBJS = $(SRCS:%.c=%.o)
BINS = $(OBJS:%.o=%)

# Flags for compilation (adding warnings are always good)
CFLAGS = -Wall -g -O2

# Flags for linking (none for the moment)
LDFLAGS = -g

# Libraries to link with (none for the moment)
LIBS =

# Use the GCC frontend program when linking
#LD = gcc

# The first target, this will be the default target if none is specified
# This target tells "make" to make the "all" target
default: all

# Target to clean up after us
all: $(BINS)

dist: mal

mal: $(word $(words $(BINS)),$(BINS))
	cp $< $@

$(OBJS): %.o: %.c

#$(patsubst %.o,%,$(filter step%,$(OBJS))): $(OTHER_OBJS)
$(BINS): %: %.o

clean:
	rm -f $(OBJS) $(BINS) mal
