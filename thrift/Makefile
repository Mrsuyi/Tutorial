#=================================== config ===================================#
CXX      := g++
CXXFLAGS := -std=c++11 -lthrift

#================================== prepare ===================================#

THRS := $(wildcard *.thrift)
THRS := $(THRS:%.thrift=%)
GHPP := $(foreach t, $(THRS), gen-cpp/$(t).h \
	                          gen-cpp/$(t)_constants.h \
							  gen-cpp/$(t)_types.h)
GCPP := $(foreach t, $(THRS), gen-cpp/$(t).cpp \
                              gen-cpp/$(t)_constants.cpp \
							  gen-cpp/$(t)_types.cpp)
ALL  := $(wildcard *.cpp) $(GCPP)
SRCS := $(filter-out server.cpp client.cpp, $(ALL)) 
OBJS := $(patsubst %, _bin/%.o, $(basename $(SRCS)))
DEPS := $(patsubst %, _bin/%.d, $(basename $(SRCS)))

#==================================== exe =====================================#

all: _bin/server.exe _bin/client.exe ;

_bin/server.exe: _bin/server.o $(OBJS)
	@-mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -o $@ $^
	
_bin/client.exe: _bin/client.o $(OBJS)
	@-mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -o $@ $^

#================================ objs & deps =================================#

DEPFLAGS     = -MT $@ -MMD -MP -MF _bin/$*.td
POSTCOMPLETE = @mv -f _bin/$*.td _bin/$*.d

_bin/%.o: %.cpp
_bin/%.o: %.cpp _bin/%.d $(GHPP)
	@-mkdir -p $(@D)
	$(CXX) $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) -c -o $@ $<
	$(POSTCOMPLETE)

_bin/%.d: ;

.PRECIOUS: _bin/%.d gen-cpp/%

-include $(DEPS)

#=================================== thrift ===================================#

gen-cpp/%.h: %.thrift
	thrift --gen cpp $^

gen-cpp/%.cpp: %.thrift
	thrift --gen cpp $^

gen-cpp/%_constants.h: %.thrift
	thrift --gen cpp $^

gen-cpp/%_constants.cpp: %.thrift
	thrift --gen cpp $^

gen-cpp/%_types.h: %.thrift
	thrift --gen cpp $^
	
gen-cpp/%_types.cpp: %.thrift
	thrift --gen cpp $^

#=================================== clean ====================================#

.PHONY: clean
clean:
	rm -rf _bin gen-cpp
