use std::env;
use std::fs;

fn main() {
  let args: Vec<String> = env::args().collect();
  // println!("Got {:?}", args);
  let query = &args[1];
  let filename = &args[2];

  println!("Searching for {}", query);
  println!("In file {}", filename);

  // let hello = String::from("Hello");
  // println!("{}", format!("- {}", hello.as_str()));
  // panic!(format!("- {}", filename));

  let contents = fs::read_to_string(filename)
    .expect(format!("Something went wrong reading the file: {}", *filename).as_str());
  println!("With text:\n{}", contents);
}
