CC     := gcc
CFLAGS := -std=c99 -lm
LEX    := flex
LFLAGS :=
YACC   := bison
YFLAGS :=

YACS := $(wildcard *.y)
BINS := $(YACS:%.y=%)

.PRECIOUS: %.lexer.c %.parser.c

all: $(BINS) ;

.PHONY: $(BINS)
$(BINS): %: %.exe

%.exe: %.parser.c %.lexer.c
	$(CC) $(CFLAGS) -o $@ $^

%.lexer.c %.lexer.h: %.l
	$(LEX) $(LFLAGS) --outfile=$*.lexer.c --header-file=$*.lexer.h $<

%.parser.c %.parser.h: %.y
	$(YACC) $(YFLAGS) --out=$*.parser.c -d $< 

.PHONY: clean
clean:
	rm -f *.c *.h *.o *.exe *.out
