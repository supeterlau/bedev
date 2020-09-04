#[derive(Debug)]

struct Rect {
  width: u32,
  height: u32,
}

impl Rect {
  fn area(&self, msg: &str) -> u32 {
    println!("message: {}", msg);
    self.width * self.height
  }

  fn can_hold(&self, other: &Rect) -> bool {
    self.width > other.width && self.height > other.height
  }

  fn square(size: u32) -> Rect {
    Rect {
      width: size,
      height: size
    }
  }

  fn new(width: u32, height: u32) -> Rect {
    Rect {
      width, height
    }
  }
}

fn main() {
  let rect1 = Rect {
    width: 33, 
    height: 55,
  };

  println!(
    "The area of rect1 si {} square pixels",
    rect1.area("Say something")
  );

  let rect2 = Rect {width: 40, height: 50};
  let rect3 = Rect {width: 30, height: 30};
  println!(
    "Can rect2 hold rect1? {}", rect1.can_hold(&rect2)
  );
  println!(
    "Can rect3 hold rect1? {}", rect1.can_hold(&rect3)
  );

  println!("Hello new method: {:?}.", Rect::new(40, 60));

  println!("Give me a square: {:#?}.", Rect::square(100));
}
