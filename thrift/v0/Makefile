# files
CPPS = server.cpp client.cpp gen-cpp/Calc.cpp
OBJS = $(CPPS:%.cpp=obj/%.o)

# compile
CC     = g++
CFLAGS = -Wall -lthrift

# tasks
all: bin/server bin/client

.PHONY: server
server: bin/server

.PHONY: client
client: bin/client

# compile-tasks
bin/%: obj/%.o obj/gen-cpp/Calc.o
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -o $@ $^

obj/%.o: %.cpp
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c -o $@ $^

# clean
.PHONY: clean
clean:
	rm -rf bin obj
