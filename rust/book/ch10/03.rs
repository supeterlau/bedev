use std::fmt::Display;

fn main() {
  let r;

  {
    let x = 5;
    r = &x;
    // 挪到内部，just fine
    println!("r: {}", r);
  }

  // println!("r: {}", r);
  
  let string1 = String::from("abcd");
  let string2 = "xyz";

  let result = longest(string1.as_str(), string2);
  println!("Longest string: {}", result);

  let string1 = String::from("long string is long");
  let result1 : String;
  {
    let string2 = String::from("xyz");
    // let result = longest(string1.as_str(), string2.as_str());
    // println!("==> longest string: {}", result);
    // result1 = longest(string1.as_str(), string2.as_str());
  }
  // 编译失败
  // println!("==> longest string: {}", result1);

  let novel = String::from("Call me Lord. Long long ago...");
  let first_sentence = novel.split('.').next().expect("Could not find a '.'");
  let f = ImportantExcerpt {
    part: first_sentence,
  };

  let string1 = String::from("Rust");
  let string2 = String::from("Lifetime");
  println!("===> RETURN {}", longest_with_text(string1.as_str(), string2.as_str(), "Generic Type Parameters"));
}

// fn longest_no_lifetime(x: &str, y: &str) -> &str {
//   if x.len() > y.len() {
//     x
//   } else {
//     y
//   }
// }

fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
  if x.len() > y.len() {
    x
  } else {
    y
  }
}

struct ImportantExcerpt<'a> {
  part: &'a str,
}

fn longest_with_text<'a, T>(
  x: &'a str,
  y: &'a str,
  text: T,
) -> &'a str
where
    T: Display
{
  println!("Text! {}", text);
  if x.len() > y.len() {
    x
  } else {
    y
  }
}
