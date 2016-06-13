# dir names
DIR_BIN = bin
DIR_OBJ = obj

# file names
FILE_CPP = $(wildcard *.cpp)
FILE_OBJ = $(FILE_CPP:%.cpp=$(DIR_OBJ)/%.o)
FILE_BIN = $(DIR_BIN)/main.exe

# main compile task
$(FILE_BIN): $(FILE_OBJ)  # create main.exe
	@mkdir -p $(@D) 
	g++ -o $@ $^

$(DIR_OBJ)/%.o: %.cpp     # create liba.o main.o
	@mkdir -p $(@D)
	g++ -c -o $@ $^

# clean
.PHONY: clean
clean:
	rm -rf $(DIR_BIN) $(DIR_OBJ)
