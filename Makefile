# Makefile for COBOL and Rust Supply Chain Management Application with Blockchain

# Variables
COBOL_SRC = COPYBOOK.cbl DATABASE.cbl SUPPLYCHAIN.cbl INTERFACE.cbl
COBOL_BIN = $(COBOL_SRC:.cbl=)
RUST_SRC = src/lib.rs src/block.rs src/chain.rs src/transaction.rs
RUST_TARGET = target/release/rust_blockchain_supply_chain_executable
COBOL_FLAGS = -free -x
RUST_BUILD_CMD = cargo build --release

# Default target
all: $(COBOL_BIN) $(RUST_TARGET)

# COBOL targets
%.cbl:
	cobc $(COBOL_FLAGS) -o $@ $<

# Rust targets
$(RUST_TARGET): $(RUST_SRC)
	$(RUST_BUILD_CMD)

# Phony targets for common actions
.PHONY: clean run

clean:
	rm -f $(COBOL_BIN)
	cargo clean

run: all
	./$(RUST_TARGET)

# Docker build target
docker:
	docker build -t supply_chain_management .

# Include any other dependencies that might be necessary for your project
# For example, if INTERFACE.cbl depends on the Rust library, you would add a custom rule for it here
