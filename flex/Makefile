LEX    := lex
CC     := gcc
CFLAGS := -lm

SRCS = $(wildcard *.l)
BINS = $(SRCS:%.l=%)

all: $(BINS)

.PHONY: $(BINS)
$(BINS): %: %.exe

%.exe: %.c
	$(CC) $(CFLAGS) -o $@ $<

%.c: %.l
	$(LEX) $(LFLAGS) -o $@ $<

.PHONY: clean
clean:
	rm -f *.c *.exe
