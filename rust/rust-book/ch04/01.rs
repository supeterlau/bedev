fn main() {
  {
    let s = "hello";
    println!("{}", s);
  }
  // println!("{}", s);

  let mut s = String::from("OK");
  s.push_str(", Apache");
  println!("{}, ", s);

  let s1 = s;
  // s 自动被认为无效，超出作用域不会被释放
  // println!("{}, ", s);
  let s2 = s1.clone();
  println!("{}, ", s1);
  println!("{}, ", s2);

  // 5
  let n = String::from("Never Be Late");

  takes_ownership(n);

  // move 到函数内，n 被 free (drop)
  // println!("{}", n);

  let v = 5;

  makes_copy(v);
  println!("{}", v);

  // 6
  let z1 = gives_ownership();

  println!("z1 {}", z1);

  let z2 = String::from("Zen of Python");

  println!("z2 {}", z2);

  let z3 = takes_and_gives_back(z2);

  println!("z3 {}", z3);

  let a1 = String::from("Awesome");
  let (a1, len) = calculate_length(a1);
  println!("The length of '{}' is {}", a1, len);
}

fn takes_ownership(s : String) {
  println!("{}", s);
}

fn makes_copy(i : i32) {
  println!("{}", i);
}

fn gives_ownership() -> String {
  let s = String::from("SuperHero");
  s
}

fn takes_and_gives_back(s : String) -> String {
  s
}

fn calculate_length(s : String) -> (String, usize) {
  let length = s.len();
  (s, length)
}
