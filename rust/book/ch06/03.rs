// #[derive(Debug)]
// `derive` may only be applied to structs, enums and unions

fn main() {
  let mut some_u8 = Some(0u8);
  match some_u8 {
    Some(3) => println!("three"),
    _ => println!("No match"),
  }

  if let Some(3) = some_u8 {
    println!("three");
  } 

  // some_u8 = Some(100);
  some_u8 = None;
  if let Some(i) = some_u8 {
    println!("a Some: {}", i);
  } else {
    println!("just a None")
  }
}
