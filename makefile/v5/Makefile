#=================================== config ==================================#
CC       := gcc
CXX      := g++
CFLAGS   := -std=c99
CXXFLAGS := -std=c++11
CPPFLAGS :=
MAKE     := make

SUBS := formula
LIBS := calc

#================================== prepare ==================================#

DIR  := _bin
LIB  := $(DIR)/lib.a
LIBS := $(LIBS:%=%/$(LIB))
BINS := $(wildcard _*.c _*.cpp)
ALL  := $(wildcard *.c *.cpp) $(wildcard $(SUBS:%=%/**.c) $(SUBS:%=%/**.cpp))
SRCS := $(filter-out $(BINS), $(ALL)) 
OBJS := $(patsubst %, $(DIR)/%.o, $(basename $(SRCS)))
BINS := $(patsubst _%, %, $(basename $(BINS)))
DEPS := $(patsubst %, $(DIR)/%.d, $(basename $(ALL)))

#==================================== exe ====================================#

all: $(BINS)

$(BINS): %: $(DIR)/%.exe

$(DIR)/%.exe: $(DIR)/_%.o $(OBJS) $(LIBS)
	@-mkdir -p $(@D)
	$(CXX) $(FLAGS) -o $@ $^ 

#================================== archive ==================================#

lib: $(LIB)

$(LIB): $(OBJS) $(LIBS)
	@-mkdir -p $(@D)
	$(AR) rcs $@ $^

#=================================== libs ====================================#

.PHONY: $(LIBS)
$(LIBS):
	$(MAKE) lib -C $(patsubst %/$(LIB), %, $@)

#================================ objs & deps ================================#

DEPFLAGS     = -MT $@ -MMD -MP -MF $(DIR)/$*.td
POSTCOMPLETE = @mv -f $(DIR)/$*.td $(DIR)/$*.d

$(DIR)/%.o: %.c
$(DIR)/%.o: %.c $(DIR)/%.d
	@-mkdir -p $(@D)
	$(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
	$(POSTCOMPLETE)

$(DIR)/%.o: %.cpp
$(DIR)/%.o: %.cpp $(DIR)/%.d
	@-mkdir -p $(@D)
	$(CXX) $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) -c -o $@ $<
	$(POSTCOMPLETE)

$(DIR)/%.d: ;

.PRECIOUS: $(DIR)/%.d

-include $(DEPS)

#=================================== clean ===================================#

.PHONY: clean
clean:
	rm -rf $(DIR)
