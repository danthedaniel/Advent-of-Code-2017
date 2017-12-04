use std::collections::HashSet;
use std::io::prelude::*;
use std::io::BufReader;
use std::fs::File;
use std::path::Path;
use std::str::Split;
use std::iter::Iterator;
use std::iter::FromIterator;

type PasswordChecker = fn(Split<&str>) -> bool;

fn main() {
    let lines = lines_from_file("input");
    println!("Part 1: {}", get_password_count(lines.clone(), password_check));
    println!("Part 1: {}", get_password_count(lines.clone(), password_check2));
}

/// Get the number of passwords that pass a password validator
fn get_password_count(lines: Vec<String>, f: PasswordChecker) -> usize {
    let is_valid: Vec<bool> = lines
        .iter()
        .map(|line| f(line.split(" ")))
        .collect();
    let mut count = 0;

    for value in is_valid {
        if value {
            count += 1;
        }
    }

    count
}

/// Credit: Shepmaster on SO
fn lines_from_file<P>(filename: P) -> Vec<String>
where
    P: AsRef<Path>,
{
    let file = File::open(filename).expect("no such file");
    let buf = BufReader::new(file);
    buf.lines()
        .map(|l| l.expect("Could not parse line"))
        .collect()
}

/// Check if a password is valid.
fn password_check(words: Split<&str>) -> bool {
    let mut word_set = HashSet::new();
    let mut count = 0;

    for word in words {
        word_set.insert(word);
        count += 1;
    }

    word_set.len() == count
}

/// Check if a password is valid (no anagrams)
fn password_check2(words: Split<&str>) -> bool {
    let mut word_set = HashSet::new();
    let mut count = 0;

    for word in words {
        word_set.insert(sort_word(word));
        count += 1;
    }

    word_set.len() == count
}

/// Credit: Shepmaster on SO
fn sort_word(word: &str) -> String {
    let s_slice: &str = &word[..];
    let mut chars: Vec<char> = s_slice.chars().collect();
    chars.sort_by(|a, b| b.cmp(a));
    String::from_iter(chars)
}
