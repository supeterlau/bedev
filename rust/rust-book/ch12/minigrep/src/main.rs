use std::env;
use std::fs;
use std::process;
use std::error::Error;

fn main() {
  let args: Vec<String> = env::args().collect();

  // println!("Got {:?}", args);

  // let (query, filename) = parse_config(&args);

  // let config = parse_config(&args);

  // let config = Config::new(&args);

  let config = Config::new(&args).unwrap_or_else(|err| {
    println!("Problem parsing arguments: {}", err);
    process::exit(1);
  });

  println!("Searching for: {}", config.query);
  println!("In file: {}", config.filename);

  // run(config);

  if let Err(e) = run(config) {
    println!("Application error: {}", e);

    process::exit(1);
  }

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
  // fn new(args: &[String]) -> Config {
  fn new(args: &[String]) -> Result<Config, &'static str> {
    if args.len() < 3 {
      // panic!("not enough arguments.");
      return Err("not enough arguments.");
    }

    let query = args[1].clone();
    let filename = args[2].clone();
    Ok(Config {query, filename})
  }
}

// fn run(config: Config) {

fn run(config: Config) -> Result<(), Box<dyn Error>> {
  // let contents = fs::read_to_string(config.filename)
  //   .expect("Something went wrong reading the file");

  let contents = fs::read_to_string(config.filename)?;

  println!("With text:\n{}", contents);

  // () Unit Type: 表示调用这个函数只产生 side effects
  Ok(())
}

fn _run_plus(config: &Config) {
  let contents = fs::read_to_string(config.filename.as_str())
    .expect(format!("Something went wrong reading the file: {}", config.filename).as_str());
  println!("With text:\n{}", contents);
}

// fn parse_config(args: &[String]) -> (&str, &str) {
// fn parse_config(args: &[String]) -> Config {
  // let query = args[1];
  // let filename = args[2];
  
  // let query = args[1].clone();
  // let filename = args[2].clone();

  // Config {query, filename}
// }
