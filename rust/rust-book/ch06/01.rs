#[derive(Debug)]

// #[derived[Debug]]

enum IpAddrKind {
  // V4,
  // V6,

  // V4(String),
  // V6(String),

  V4(u8, u8, u8, u8),
  V6(String),
}

struct IpAddr {
  kind: IpAddrKind,
  address: String,
}

enum Message {
  Quit,
  Move {x:i32, y:i32},
  Write(String),
  ChangeColor(i32, i32,i32),
}

impl Message {
  fn call(&self) {
    // println!("Show msg: {:?}", self);
    println!("Show msg");
  }
}

fn main() {
  let four = IpAddrKind::V4;
  let six = IpAddrKind::V6;

  /*
  let home = IpAddr {
    kind: IpAddrKind::V6,
    address: String::from("127.0.0.1"),
  };

  let loopback = IpAddr {
    kind: four,
    address: String::from("::1"),
  };

  let home = IpAddr::V4(String::from("127.0.0.1"));
  let loopback = IpAddr::V6(String::from("::1"));
  */

  let home = IpAddrKind::V4(127,0,0,1);
  let loopback = IpAddrKind::V6(String::from("::1"));

  let msg = Message::Write(String::from("Well done"));
  msg.call();

  let some_number  = Some(5);
  let some_string = Some("just a string");
  let absent_number: Option<i32> = None;

  let mut x = Some(2);
  match x.as_mut() {
    Some(v) => *v = 42,
    None => {},
  }
  assert_eq!(x, Some(42));
}

fn route(ip_kind: IpAddrKind) {

}
