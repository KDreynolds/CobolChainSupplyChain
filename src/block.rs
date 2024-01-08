// src/block.rs

use serde::{Serialize, Deserialize};
use sha2::{Sha256, Digest};
use chrono::prelude::*;
use super::transaction::Transaction;

/// A block in the blockchain.
#[derive(Serialize, Deserialize, Debug)]
pub struct Block {
    pub index: u64,
    pub timestamp: i64,
    pub transactions: Vec<Transaction>,
    pub previous_hash: String,
    pub nonce: u64,
    pub hash: String,
}

impl Block {
    /// Creates a new block.
    pub fn new(index: u64, transactions: Vec<Transaction>, previous_hash: String) -> Self {
        Block {
            index,
            timestamp: Utc::now().timestamp(),
            transactions,
            previous_hash,
            nonce: 0,
            hash: String::new(),
        }
    }

    /// Calculates the hash of the block.
    pub fn calculate_hash(&self) -> String {
        let mut hasher = Sha256::new();
        hasher.update(self.index.to_string().as_bytes());
        hasher.update(self.timestamp.to_string().as_bytes());
        hasher.update(self.transactions.iter().map(|transaction| transaction.to_string()).collect::<Vec<String>>().join("").as_bytes());
        hasher.update(self.previous_hash.as_bytes());
        hasher.update(self.nonce.to_string().as_bytes());
        format!("{:x}", hasher.finalize())
    }

    /// Mines the block with a given difficulty.
    pub fn mine(&mut self, difficulty: usize) {
        let prefix = "0".repeat(difficulty);
        while !self.hash.starts_with(&prefix) {
            self.nonce += 1;
            self.hash = self.calculate_hash();
        }
    }
}

// Implementing the Display trait for Block to make it easier to print and log.
impl std::fmt::Display for Block {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "Block {{\n  index: {},\n  timestamp: {},\n  transactions: {:?},\n  previous_hash: \"{}\",\n  nonce: {},\n  hash: \"{}\"\n}}",
               self.index, self.timestamp, self.transactions, self.previous_hash, self.nonce, self.hash)
    }
}

// Implementing ToString for Transaction to be used in calculate_hash.
impl ToString for Transaction {
    fn to_string(&self) -> String {
        serde_json::to_string(&self).unwrap()
    }
}
