CC    := g++
FLAGS := -std=c++11 
MAKE  := make
SUBS  :=
LIBS  :=

#==================== files ====================#

DIR  := _bin
LIB  := $(DIR)/lib.a
ALL  := $(wildcard *.cpp) $(wildcard $(SUBS:%=%/**.cpp))
DEPS := $(ALL:%.cpp=$(DIR)/%.d)
BINS := $(wildcard _*.cpp)
SRCS := $(filter-out $(BINS), $(ALL)) 
BINS := $(BINS:%.cpp=$(DIR)/%.exe)
OBJS := $(SRCS:%.cpp=$(DIR)/%.o)
LIBS := $(LIBS:%=%/$(LIB))

.PRECIOUS: $(DIR)/%.o $(DIR)/%.d

#==================== bin ====================#

all: $(BINS)

$(DIR)/%.exe: $(DIR)/%.o $(OBJS) $(LIBS)
	@-mkdir -p $(@D)
	$(CC) $(FLAGS) -o $(patsubst $(DIR)/_%, $(DIR)/%, $@) $^ 

#==================== lib ====================#

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
