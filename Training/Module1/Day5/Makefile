# Variables
CC = gcc
CFLAGS = -Wall -Wextra -g

# Pattern rule: How to turn any .c file into a .o file
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Default target
all: program

# Link the object files to create the final executable
program: main.o utils.o
	$(CC) $(CFLAGS) -o $@ $^

# Phony targets so Make knows these aren't real files
.PHONY: all clean test

# Test target
test: program
	@echo "Running tests..."
	./program

# Clean target
clean:
	rm -f *.o program
# Help target
help:
	@echo "Available targets:"
	@echo "  all     - Builds the main program (default)"
	@echo "  program - Links the object files into the executable"
	@echo "  test    - Builds and runs the program"
	@echo "  clean   - Removes all generated .o files and the executable"
	@echo "  help    - Prints this help message"
