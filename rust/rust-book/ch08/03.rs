use std::collections::HashMap;

fn main() {
  let mut scores = HashMap::new();

  scores.insert(String::from("Blue"), 10);
  scores.insert(String::from("Yellow"), 50);
  println!("Display scores: {:?}", scores);

  let teams = vec![String::from("Blue"), String::from("Yello")];
  let initial_scores = vec![30, 60];

  let mut iter_scores: HashMap<_, _> = 
    teams.into_iter().zip(initial_scores.into_iter()).collect();
  println!("Display iter_scores: {:?}", iter_scores);

  // let field_name = String::from("Color");
  // let field_value = String::from("Blue");

  let field_name = 111;
  let field_value = 222;

  let mut map  = HashMap::new();
  map.insert(field_name, field_value);
  println!("field_name {}; field_value {}", field_name, field_value);

  let team_name = String::from("Blue");
  // with unwrap_or
  println!("Score of Blue: {}", scores.get(&team_name).unwrap_or(&0));

  for(key, value) in &scores {
    println!("{}: {}", key, value);
  }

  println!("Display scores: {:?}", scores);
  scores.insert(String::from("Blue"), 900);
  println!("Display scores: {:?}", scores);

  let mut value = scores.entry(String::from("Gold")).or_insert(600);
  {
    *value = 300;
    // scores 是 引用 
    // println!("Display scores: {:?}", scores);
  }
  *value = 500;
  println!("Display scores: {:?}", scores);
  scores.entry(String::from("Blue")).or_insert(0);
  println!("Display scores: {:?}", scores);

  let text  = "Rust Python Ruby Perl Java Ruby Python Ruby Java";
  let mut lang_map = HashMap::new();

  for lang in text.split_whitespace() {
    let count = lang_map.entry(lang).or_insert(0);
    *count += 1;
  }
  println!("{:?}", lang_map);
}
