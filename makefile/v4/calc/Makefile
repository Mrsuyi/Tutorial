CC    = g++
FLAGS = -I top_flag
MAKE  = make -e

DIR   = _build
BIN   = $(DIR)/main.exe
LIB   = $(DIR)/lib.a
SUBS  =
LIBS  =
MAIN  = _test.cpp


# bin 

SRCS := $(wildcard *.cpp) $(wildcard $($(SUBS):%=%/*.cpp))
OBJS := $(SRCS:%.cpp=$(DIR)/%.o)
LIBS := $(LIBS:%=%/$(LIB))

all: $(BIN)

$(BIN): $(OBJS) $(LIBS)
	@-mkdir -p $(@D)
	$(CC) $(FLAGS) -o $@ $^ 


# lib

SRCS := $(filter-out $(MAIN), $(SRCS))
OBJS := $(SRCS:%.cpp=$(DIR)/%.o)

lib: $(LIB)

$(LIB): $(OBJS) $(LIBS)
	@-mkdir -p $(@D)
	ar rcs $@ $^


# make sub-folders

%/$(LIB): % 
	export FLAGS
	export DIR
	export ARC
	export MAKE	
	$(MAKE) lib -C ./$<


# compile

$(DIR)/%.o: %.cpp
	@-mkdir -p $(@D)
	$(CC) $(FLAGS) -c -o $@ $<


# clean

.PHONY: clean
clean:
	rm -rf $(DIR)
