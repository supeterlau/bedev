
fn main() {
  // let v: Vec<i32> = Vec::new();
  // let v = vec![1,2,3];

  let mut v = Vec::new();

  v.push(12);
  v.push(13);
  v.push(15);
  v.push(-100);

  println!("vector v: {:?}", v);

  let third: &i32 = &v[2];
  println!("The third element of v : {}", third);

  match v.get(3) {
    // four: &i32
    Some(four) => println!("The forth element of v : {}", four),
    None => println!("No forth element"),
  }

  let mut v4 = vec![4,5,6];
  let v4_first = &v4[0];
  // v4.push(7);
  println!("First of v5: {}", v4_first);

  let v5 = vec![100,200,300];
  for i in &v5 {
    println!("v5: {}", i);
  }

  let mut v5_mut = vec![100,200,300];
  for i in &mut v5_mut {
    *i *= 5;
    println!("v5: {}", i);
  }

  let row = vec![
    SpreadsheetCell::Int(3),
    SpreadsheetCell::Text(String::from("red")),
    SpreadsheetCell::Float(3.14),
  ];
  println!("row {:?}", row);

  // let pop_v = v5.pop();
  // println!("Get a pop value: {}", pop_v);
  match v5_mut.pop() {
    Some(pop_v) => println!("Show pop value {}", pop_v),
    None => println!("Can't pop"),
  }
}

#[derive(Debug)]
enum SpreadsheetCell {
  Int(i32),
  Float(f64),
  Text(String),
}
