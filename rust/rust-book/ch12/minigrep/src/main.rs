use std::env;
use std::fs;

fn main() {
  let args: Vec<String> = env::args().collect();

  // println!("Got {:?}", args);

  // let (query, filename) = parse_config(&args);

  // let config = parse_config(&args);

  let config = Config::new(&args);

  println!("Searching for: {}", config.query);
  println!("In file: {}", config.filename);

  // let hello = String::from("Hello");
  // println!("{}", format!("- {}", hello.as_str()));
  // panic!(format!("- {}", filename));

  // let contents = fs::read_to_string(filename)
  //   .expect(format!("Something went wrong reading the file: {}", *filename).as_str());
  // println!("With text:\n{}", contents);
}

struct Config {
  query: String,
  filename: String,
}

impl Config {
  fn new(args: &[String]) -> Config {
    let query = args[1].clone();
    let filename = args[2].clone();
    Config {query, filename}
  }
}

// fn parse_config(args: &[String]) -> (&str, &str) {
// fn parse_config(args: &[String]) -> Config {
  // let query = args[1];
  // let filename = args[2];
  
  // let query = args[1].clone();
  // let filename = args[2].clone();

  // Config {query, filename}
// }
