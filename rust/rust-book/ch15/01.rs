//
// 01.rs
// Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
// Distributed under terms of the MIT license.
//


enum List {
  // Cons(i32, List), // OCaml style
  Cons(i32, Box<List>),
  Nil,
}

// use crate::List::{Cons, Nil};

fn main() {
	let b = Box::new(5000);
	println!("b is {}", b);


  // let list = Cons(1, Cons(2, Cons(3, Nil)));
  let list = List::Cons(1, Box::new(List::Cons(2, Box::new(List::Cons(3, Box::new(List::Nil))))));
}
