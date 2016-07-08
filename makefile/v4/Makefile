CC    = g++
FLAGS = -std=c++11 
MAKE  = make -e

DIR   := _build
BIN   := $(DIR)/main.exe
LIB   := $(DIR)/lib.a
SUBS  := formula
LIBS  := calc
MAIN  := _test.cpp

#==================== files ====================#

SRCS := $(wildcard *.cpp) $(wildcard $(SUBS:%=%/**.cpp))
OBJS := $(SRCS:%.cpp=$(DIR)/%.o)
LIBS := $(LIBS:%=%/$(LIB))

ifeq ($(MAKECMDGOALS), lib)
	SRCS := $(filter-out $(MAIN), $(SRCS))
	OBJS := $(SRCS:%.cpp=$(DIR)/%.o)
endif	

DEPS := $(OBJS:%.o=%.d)

#==================== make bin ====================#

all: $(BIN)

$(BIN): $(OBJS) $(LIBS)
	@-mkdir -p $(@D)
	$(CC) $(FLAGS) -o $@ $^ 

#==================== make lib ====================#

lib: $(LIB)

$(LIB): $(OBJS) $(LIBS)
	@-mkdir -p $(@D)
	ar rcs $@ $^

#==================== make sub-folders ====================#

.PHONY: $(LIBS)
$(LIBS):
	@export DIR
	@export LIB
	@export MAKE
	$(MAKE) lib -C $(patsubst %/$(LIB), %, $@)

#==================== generate .d ====================#

-include $(DEPS)

$(DIR)/%.d: %.cpp
	@-mkdir -p $(@D)
	@set -e; rm -f $@; $(CC) $(FLAGS) -MM -MT $(patsubst %.d,%.o,$@) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

#==================== compile ====================#

$(DIR)/%.o: %.cpp
	@-mkdir -p $(@D)
	$(CC) $(FLAGS) -c -o $@ $<

#==================== clean ====================#

.PHONY: clean
clean:
	rm -rf $(DIR)
