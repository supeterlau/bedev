use std::collections::HashMap;

#[derive(Debug)]
struct Point {
  x: u8,
  y: u8,
}

fn main() {
  let mut map = HashMap::new();
  map.insert(1, 2);
  println!("map: {:?}", map);

  let p = Point {
    x: 10,
    y: 10,
  };
  println!("p: {:?}", p);
}
