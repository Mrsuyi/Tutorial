CC    := g++
FLAGS := -std=c++11 
MAKE  := make
SUBS  := formula
LIBS  := calc

#==================== files ====================#

DIR  := _bin
LIB  := $(DIR)/lib.a
ALL  := $(wildcard *.cpp) $(wildcard $(SUBS:%=%/**.cpp))
DEPS := $(ALL:%.cpp=$(DIR)/%.d)
BINS := $(wildcard _*.cpp)
SRCS := $(filter-out $(BINS), $(ALL)) 
BINS := $(BINS:_%.cpp=%)
OBJS := $(SRCS:%.cpp=$(DIR)/%.o)
LIBS := $(LIBS:%=%/$(LIB))

.PRECIOUS: $(DIR)/%.o $(DIR)/**/%.d

#==================== exe ====================#

all: $(BINS)

$(BINS): %: $(DIR)/%.exe

$(DIR)/%.exe: $(DIR)/_%.o $(OBJS) $(LIBS)
	@-mkdir -p $(@D)
	$(CC) $(FLAGS) -o $@ $^ 

#==================== archive ====================#

lib: $(LIB)

$(LIB): $(OBJS) $(LIBS)
	@-mkdir -p $(@D)
	ar rcs $@ $^

#==================== ref-libs ====================#

.PHONY: $(LIBS)
$(LIBS):
	$(MAKE) lib -C $(patsubst %/$(LIB), %, $@)

#==================== .o ====================#

$(DIR)/%.o: $(DIR)/%.d %.cpp
	@-mkdir -p $(@D)
	$(CC) $(FLAGS) -c -o $@ $(patsubst $(DIR)/%.o, %.cpp, $@) 

#==================== .d ====================#

$(DIR)/%.d: %.cpp
	@-mkdir -p $(@D)
	$(CC) $(FLAGS) -MM -MT $(patsubst %.d, %.o, $@) -MF $@ $<

include $(DEPS)

#==================== clean ====================#

.PHONY: clean
clean:
	rm -rf $(DIR)
