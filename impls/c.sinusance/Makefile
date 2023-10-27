# The name of the source files
SRCS = step0_repl.c 

# Flags for compilation (adding warnings are always good)
CFLAGS = -Wall -g -O2

# Flags for linking (none for the moment)
LDFLAGS = -g

# Libraries to link with (none for the moment)
LIBS =

# Use the GCC frontend program when linking
LD = gcc

# This creates a list of object files from the source files
OBJS = $(SRCS:%.c=%.o)
# The name of the executable
BINS = $(OBJS:%.o=%)

# The first target, this will be the default target if none is specified
# This target tells "make" to make the "all" target
default: all

# Having an "all" target is customary, so one could write "make all"
# It depends on the executable program
all: $(EXE)

# This will link the executable from the object files
$(EXE): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o  $(EXE) $(LIBS)

# This is a target that will compiler all needed source files into object files
# We don't need to specify a command or any rules, "make" will handle it automatically
%.o: %.c

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
