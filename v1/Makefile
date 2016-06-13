# define file names
SRC = main.cpp
EXE = bin/main.exe

# main compile task
$(EXE): $(SRC)
	@mkdir -p $(@D)
	g++ -o $@ $^

# clean
.PHONY: clean
clean:
	rm $(EXE)
