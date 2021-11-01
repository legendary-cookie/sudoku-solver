TARGET = solver

CSOURCES = $(shell find src -name \*.c)
CXXSOURCES += $(shell find src -name \*.cpp)

OBJ = $(patsubst src/%, obj/%, $(CSOURCES:.c=.o)) 
OBJ += $(patsubst src/%, obj/%, $(CXXSOURCES:.cpp=.o))

LD ?= ld
CC ?= clang
CXX ?= clang++

CFLAGS = -O3
CXXFLAGS = -O3
INC = -Iinclude/


$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

obj/%.o: src/%.c
	@# Make sure the output dir exists
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INC) -c -o $@ $<

obj/%.o: src/%.cpp
	@# Make sure the output dir exists
	@mkdir -p $(dir $@)
	@$(CC) $(CXXFLAGS) $(INC) -c -o $@ $<

.PHONY: clean	
clean:
	@# Remove obj dir
	@rm -rf ./obj/
	@# Remove target binary
	@rm -f $(TARGET)

.PHONY: ignore
ignore:
	@printf "/obj/\n/$(TARGET)\n" >.gitignore
