//
// 02.rs
// Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
// Distributed under terms of the MIT license.
//

use std::ops::Deref;

struct MBox<T>(T);

impl <T> MBox<T> {
  fn new(x: T) -> MBox<T> {
    MBox(x)
  }
}

// MBox::new(vaue)

impl<T> Deref for MBox<T> {
  type Target = T;

  fn deref(&self) -> &T {
    &self.0
  }
}

fn handle_str(name: &str) {
  println!("Great, {}!", name);
}

fn main() {
  let x = 5;
  let y = MBox::new(x);

  assert_eq!(5, x);
  assert_eq!(5, *y);

  let msg = MBox::new(String::from("RustBook"));
  handle_str(&msg);
  // 如果没有 deref coercions 
  // [..] take a string slice of whole string
  // handle_str(&(*m)[..]);
}

