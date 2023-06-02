fn main() {
  let mut s = String::new();

  let data = "real content";
  let s_data = data.to_string();
  let s_data = "Word".to_string();

  let s_from = String::from("耗时");

  let mut s_3 = String::from("return");
  let s_3_1 = " ";
  s_3.push_str(s_3_1);

  println!("Display s_3: {}$", s_3);

  // println!("s_3_1 {}", s_3_1);

  // let s_3_2 = String::from("of");
  // let s_3_3 = s_3 + &s_3_2;

  let s_3_2 = "of";
  let s_3_3 = s_3 + s_3_2;
  println!("Display s_3_3: {}$", s_3_3);
  // println!("Display s_3: {}$", s_3);

  let add_1 = String::from("tic");
  let add_2 = String::from("tac");
  let add_3 = String::from("toe");

  // Error:
  // println!("use + {}", add_1 + "-" + &add_2 + "-" + &add_3);
  // println!("use format! {}", format!("{}-{}-{}", add_1, add_2, add_3));

  println!("use format! {}", format!("{}-{}-{}", add_1, add_2, add_3));
  println!("use + {}", add_1 + "-" + &add_2 + "-" + &add_3);

  let s_4 = String::from("Hola");
  println!("s_4 lenght: {}", s_4.len());

  let s_4_1 = String::from("Здравствуйте");
  println!("s_4_1 lenght: {}", s_4_1.len());

  println!("string slice {}", &s_4_1[0..4]);

  for c in "नमस्ते".chars() {
    println!("=>_{} ", c);
  }

  for b in "नमस्ते".bytes() {
    println!("=>_{} ", b);
  }
}
