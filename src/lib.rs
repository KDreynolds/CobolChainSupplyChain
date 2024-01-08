// src/lib.rs

// External crates used by our blockchain implementation
extern crate serde;
extern crate serde_json;
extern crate sha2;
extern crate chrono;

// Importing modules from the same crate
pub mod block;
pub mod chain;
pub mod transaction;

// Re-exporting structs and enums so they can be accessed directly through the crate
pub use block::Block;
pub use chain::Blockchain;
pub use transaction::Transaction;

// This file acts as the entry point for the library part of our application.
// Here, we can also include shared utility functions or common constants if needed.

// For example, we might want to define the difficulty of our blockchain's proof of work algorithm
pub const DIFFICULTY_PREFIX: &str = "00"; // The number of leading zeros in the hash

// We could also define a function to handle the hashing of blocks, transactions, etc.
// However, since we have a separate module for blocks, the hashing functionality
// is likely already implemented there.

// If there were any shared types or traits that both the blockchain and the COBOL
// supply chain management application needed to use, they would be defined here.

// Since the COBOL part of the application is not directly interoperable with Rust,
// we would need to define an interface (possibly using FFI - Foreign Function Interface)
// to allow COBOL to communicate with the Rust code. This might involve creating C-compatible
// functions and using `extern` blocks, but that is beyond the scope of this file and would
// likely be part of the INTERFACE.cbl file or another Rust file dedicated to FFI.

// For now, this file will remain relatively simple, serving as a hub for the other modules.
