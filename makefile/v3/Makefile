# path
DIR_LIB = lib
DIR_SRC = src
DIR_OBJ = obj
DIR_BIN = bin

# cmd param
CFLAGS = -I $(DIR_LIB) -I $(DIR_SRC) -Wall
CC     = g++

# main compile task
BINS = $(DIR_BIN)/exe
all: $(BINS)

# files
FILE_CPPS = $(wildcard $(DIR_LIB)/*.cpp) $(wildcard $(DIR_SRC)/*.cpp)
FILE_OBJS = $(FILE_CPPS:%.cpp=$(DIR_OBJ)/%.o)
FILE_DEPS = $(FILE_OBJS:.o=.d)

# log
$(info FILE_CPPS is ${FILE_CPPS})
$(info FILE_OBJS is ${FILE_OBJS})
$(info FILE_DEPS is ${FILE_DEPS})

# include
-include $(FILE_DEPS)

# compile tasks

$(DIR_BIN)/exe: $(FILE_OBJS)
	@mkdir -p $(@D)
	$(CC) -o $@ $^

$(DIR_OBJ)/%.o: %.cpp
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -MM -MT $@ -MF $(patsubst %.o,%.d,$@) $<
	$(CC) $(CFLAGS) -c -o $@ $<

# clean
.PHONY: clean
clean:
	rm -rf $(BINS) $(DIR_OBJ)
