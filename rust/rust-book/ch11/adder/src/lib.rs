#[derive(Debug)]
struct Rect {
  width: u32,
  height: u32,
}

impl Rect {
  fn can_hold(&self, other: &Rect) -> bool {
    self.width > other.width && self.height > other.height
    // make a bug
    // self.width < other.width && self.height > other.height
  }
}

pub fn add_two(a: i32) -> i32 {
  a + 2
  // let test failed
  // a + 3
}

pub struct Guess {
  value: i32,
}

impl Guess {
  pub fn new(value: i32) -> Guess {
    // if value < 1 || value > 100 {
    // if value < 1 {
    //   panic!("Guess value must be between 1 and 100");
    // }
    if value < 1 {
      panic!(
        "Guess value must be greater than or equal to 1, got {}.",
        value
      );
    } else if value > 100 {
      panic!(
        "Guess value must be less than or equal to 100, got {}.",
        value
      );
    }
    Guess {value}
  }
}

// ch11-02

fn prints_and_returns_10(a: i32) -> i32 {
  println!("I got the value {}", a);
  10
}

// ch11-03

fn internal_adder(a: i32, b: i32) -> i32 {
  a + b
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  // fn it_works() {
  fn exploration() {
      assert_eq!(2 + 2, 4);
  }

  #[test]
  fn another() {
    // panic!("Failed test");
    assert_eq!(2 + 2, 4);
  }

  #[test]
  fn larger_can_hold_smaller() {
    let larger = Rect {
      width: 8,
      height: 7,
    };
    let smaller = Rect {
      width: 5,
      height: 1,
    };
    assert!(larger.can_hold(&smaller));
  }

  #[test]
  fn smaller_cannot_hold_larger() {
    let larger = Rect {
      width: 8,
      height: 7,
    };
    let smaller = Rect {
      width: 5,
      height: 1,
    };
    assert!(!smaller.can_hold(&larger));
  }

  #[test]
  fn it_adds_two() {
    assert_eq!(4, add_two(2));
  }

  #[test]
  #[should_panic]
  fn greater_than_100() {
    Guess::new(200);
  }

  #[test]
  #[should_panic(expected = "Guess value must be greater than or equal to 1")]
  fn less_than_1() {
    // Guess::new(200);
    Guess::new(0);
  }

  #[test]
  fn test_use_result() -> Result<(), String> {
    if 2 + 2 == 4 {
    // if 2 + 2 == 5 {
      Ok(())
    } else {
      Err(String::from("two plus two does not equal four"))
    }
  }

  #[test]
  fn this_test_will_pass() {
    let value = prints_and_returns_10(4);
    assert_eq!(10, value);
  }

  #[test]
  fn this_test_will_fail() {
    let value = prints_and_returns_10(8);
    assert_eq!(5, value);
  }

  #[test]
  fn add_two_and_two_02() {
    assert_eq!(4, add_two(2));
  }

  #[test]
  fn add_three_and_two_02() {
    assert_eq!(5, add_two(3));
  }

  #[test]
  fn one_hundred_and_two_02() {
    assert_eq!(102, add_two(100));
  }

  #[test]
  fn internal_fn() {
    assert_eq!(4, internal_adder(2, 2));
  }
}
