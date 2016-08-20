CC     := gcc
CFLAGS := -std=c99 -lm
LEX    := flex
LFLAGS :=
YACC   := bison
YFLAGS := -d

YACS := $(wildcard *.y)
BINS := $(YACS:%.y=%)

all: $(BINS) ;

.PHONY: $(BINS)
$(BINS): %: %.exe

%.exe: %.tab.c %.c
	$(CC) $(CFLAGS) -o $@ $^

%.c: %.l %.tab.h
	$(LEX) $(LFLAGS) -o $@ $<

%.tab.c %.tab.h: %.y
	$(YACC) $(YFLAGS) $<

.PHONY: clean
clean:
	rm -f *.c *.h *.o *.exe *.out
