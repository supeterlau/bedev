#[derive(Debug)]

enum UsState {
  Alabama,
  Alaska,
}

enum Coin {
  Penny,
  Nickel,
  Dime,
  Quarter(UsState),
}

fn main() {
  let coin = Coin::Quarter(UsState::Alaska);
  let value = value_in_cents(coin);
  println!("Match value: {}", value);

  let five = Some(5);
  let six = plus_one(five);
  let none = plus_one(None);
  println!("five -> {:?} six -> {:?} none -> {:?}", five, six, none);
}

fn value_in_cents(coin: Coin) -> u8 {
  match coin {
    // Coin::Penny => 1,
    Coin::Penny => {
      println!("Lucky penny!");
      1
    }
    Coin::Nickel => 5,
    Coin::Dime => 10,
    // Coin::Quarter => 25,
    Coin::Quarter(state) => {
      println!("State quarter from {:?}!", state);
      25
    }
    // value_in_cents(Coin::Quarter(UsState::Alaska)) 
    // coin 值为 Coin::Quarter(UsState::Alaska) 匹配最后的 arm
    // state 绑定为 UsState::Alaska
  }
}

// a function takes an Option<i32>
fn plus_one(x: Option<i32>) -> Option<i32> {
  match x {
    None => None,
    Some(i) => Some(i + 1),
  }
}
