use std::net::IpAddr;

fn main() {
  let home: IpAddr = "127.0.0.1".parse().unwrap();
  // let home: IpAddr = "127.0.0.1".parse();
  println!("home ip: {:?}", home);

  let guess = "101";

  loop {
    let guess: i32 = match guess.trim().parse() {
      Ok(num) => num,
      Err(_) => continue,
    };

    if guess < 1 || guess > 100 {
      println!("Number will be only between 1 and 100");
      // continue;
    }
    break;
    // more guess
  }
  let guess = Guess::new(101);
}

pub struct Guess {
  value: i32,
}

impl Guess {
  pub fn new(value: i32) -> Guess {
    if value < 1 || value > 100 {
      panic!("Guess value must be between 1 and 100, got {}", value);
    }
    Guess { value }
  }

  pub fn value(&self) -> i32 {
    self.value
  }
}
