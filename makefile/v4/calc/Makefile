CC    = g++
FLAGS = -I top_flag
MAKE  = make -e
DIR   = _build
LIB   = $(DIR)/lib.a
BIN   = $(DIR)/main.exe
SUBS  = 
MAIN  = _test.exe

BIN_SRCS = $(wildcard *.cpp)
BIN_OBJS = $(BIN_SRCS:%.cpp=$(DIR)/%.o)
SUB_LIBS = $(SUBS:%=%/$(LIB))
LIB_SRCS = $(filter-out $(MAIN), $(BIN_SRCS))
LIB_OBJS = $(LIB_SRCS:%.cpp=$(DIR)/%.o)

# bin 
all: $(DIR) $(BIN) 

$(BIN): $(BIN_OBJS) $(SUB_LIBS)
	$(CC) $(FLAGS) -o $@ $^ 

$(SUB_LIBS): $(SUBS)
	export FLAGS
	export DIR
	export LIB
	export MAKE	
	$(MAKE) lib -C ./$<

# lib
lib: $(DIR) $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $@ $^

# mkdir
$(DIR):
	@-mkdir -p $@

# compile
$(DIR)/%.o: %.cpp
	$(CC) $(FLAGS) -c -o $@ $<

# clean
.PHONY: clean
clean:
	rm -rf $(DIR)
