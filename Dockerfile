# Use an official Rust image as a parent image
FROM rust:latest as builder

# Create a directory for the Rust application
WORKDIR /usr/src/rust_blockchain_supply_chain

# Copy the Rust project files into the container
COPY ./Cargo.toml ./Cargo.toml
COPY ./src ./src

# Build the Rust blockchain application
RUN cargo build --release

# Use an official open-cobol image as a parent image for COBOL environment
FROM debian:bullseye-slim

# Install GnuCOBOL
RUN apt-get update && apt-get install -y gnucobol

# Create a directory for the COBOL application
WORKDIR /usr/src/cobol_supply_chain

# Copy the COBOL source files into the container
COPY ./*.cbl ./

# Copy the compiled Rust binary from the builder stage
COPY --from=builder /usr/src/rust_blockchain_supply_chain/target/release/rust_blockchain_supply_chain_executable .

# Compile the COBOL source files
RUN for file in *.cbl; do cobc -free -x -o "$file.exe" "$file"; done

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["./rust_blockchain_supply_chain_executable"]
