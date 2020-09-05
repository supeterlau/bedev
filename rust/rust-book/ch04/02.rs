fn main() {
  let s1 = String::from("Rust");

  // let mut s2 = "Haskell";
  let mut s2 = String::from("Haskell");

  let len = calculate_length(&s1);

  println!("Length of \"{}\" : {}", s1, len);

  // modify borrowing
  // change_str(&mut s2);
  change(&mut s2);

  println!("s2 value: {}", s2);

  let ref_to_nothing = dangle();
}

fn calculate_length(s: &String) -> usize  {
  s.len()
}

fn change(s: &mut String) {
  s.push_str("#Prolog");
}

// fn change_str(s: &mut str) {
  // expected mutable reference `&mut str`
                      // found reference `&'static str
  // cannot assign to immutable argument
  // s = "After change"
// }

fn dangle() -> String {
// fn dangle() -> &String {
  let s = String::from("testing");
  // &s
  s
} // dangle 函数外 s 已经被清除 deallocated。解决方法是返回 s，move out ownership
