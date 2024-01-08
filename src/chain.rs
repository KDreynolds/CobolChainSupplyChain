// src/chain.rs

use super::block::Block;
use super::transaction::Transaction;
use super::DIFFICULTY_PREFIX;
use serde::{Serialize, Deserialize};

/// The blockchain itself, a chain of blocks.
#[derive(Serialize, Deserialize, Debug)]
pub struct Blockchain {
    pub blocks: Vec<Block>,
}

impl Blockchain {
    /// Creates a new blockchain with a genesis block.
    pub fn new() -> Self {
        let mut blockchain = Blockchain { blocks: Vec::new() };
        blockchain.create_genesis_block();
        blockchain
    }

    /// Generates the genesis block for the blockchain.
    fn create_genesis_block(&mut self) {
        let genesis_block = Block::new(0, vec![], String::from("0"));
        self.blocks.push(genesis_block);
    }

    /// Adds a new block to the blockchain after mining it.
    pub fn add_block(&mut self, transactions: Vec<Transaction>) {
        let previous_hash = if let Some(block) = self.blocks.last() {
            block.hash.clone()
        } else {
            String::from("0")
        };

        let mut new_block = Block::new(self.blocks.len() as u64, transactions, previous_hash);
        new_block.mine(DIFFICULTY_PREFIX.len());
        self.blocks.push(new_block);
    }

    /// Validates the integrity of the blockchain.
    pub fn is_valid(&self) -> bool {
        for (i, block) in self.blocks.iter().enumerate() {
            if block.hash != block.calculate_hash() {
                return false;
            }

            if i > 0 && block.previous_hash != self.blocks[i - 1].hash {
                return false;
            }
        }
        true
    }

    /// Returns the last block in the blockchain, if there is one.
    pub fn last_block(&self) -> Option<&Block> {
        self.blocks.last()
    }
}

// Implementing the Display trait for Blockchain to make it easier to print and log.
impl std::fmt::Display for Blockchain {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        for block in &self.blocks {
            write!(f, "{}\n", block)?;
        }
        Ok(())
    }
}
