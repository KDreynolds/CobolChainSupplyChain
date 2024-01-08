// src/transaction.rs

use serde::{Serialize, Deserialize};
use sha2::{Sha256, Digest};
use chrono::prelude::*;

/// A transaction to be included in a block.
#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Transaction {
    pub sender: String,
    pub recipient: String,
    pub amount: f64,
    pub timestamp: i64,
}

impl Transaction {
    /// Creates a new transaction.
    pub fn new(sender: String, recipient: String, amount: f64) -> Self {
        Transaction {
            sender,
            recipient,
            amount,
            timestamp: Utc::now().timestamp(),
        }
    }

    /// Calculates the hash of the transaction.
    pub fn calculate_hash(&self) -> String {
        let mut hasher = Sha256::new();
        hasher.update(self.sender.as_bytes());
        hasher.update(self.recipient.as_bytes());
        hasher.update(self.amount.to_string().as_bytes());
        hasher.update(self.timestamp.to_string().as_bytes());
        format!("{:x}", hasher.finalize())
    }
}

// Implementing the Display trait for Transaction to make it easier to print and log.
impl std::fmt::Display for Transaction {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "Transaction {{\n  sender: \"{}\",\n  recipient: \"{}\",\n  amount: {},\n  timestamp: {}\n}}",
               self.sender, self.recipient, self.amount, self.timestamp)
    }
}

// Implementing ToString for Transaction to be used in calculate_hash.
impl ToString for Transaction {
    fn to_string(&self) -> String {
        serde_json::to_string(&self).unwrap()
    }
}
