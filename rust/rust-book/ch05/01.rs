struct User {
  username: String,
  email: String,
  sign_in_count: u64,
  active: bool,
}

fn main() {
  let user1 = User {
    email: String::from("user1@example.com"),
    username: String::from("user1"),
    active: true,
    sign_in_count: 1,
  };
  let mut user2 = User {
    email: String::from("user2@example.com"),
    username: String::from("user2"),
    active: false,
    sign_in_count: 2,
  };

  println!("user1 name: {}", user1.username);

  println!("user2 email: {}", user2.email);
  user2.email = String::from("new_user2@example.com");
  println!("user2 : {}", user2.email);

  println!("build user tedious: {}", build_user_tedious(
      String::from("Jack@example.com"),
      String::from("Jack")
  ).active);

  let user3 = User {
      email: String::from("another@example.com"),
      username: String::from("anotherusername567"),
      ..user1
  };
  println!("user3 : {}", user3.email);

  let black = Color(100, 0, 0);
  println!("r field of black: {}", get_color_r(black));

  println!("Ch5 01");
  // print!("Ch5 01");
}

fn build_user(email: String, username: String) -> User {
  User {
    email,
    username,
    active: true,
    sign_in_count: 1,
  }
}

fn build_user_tedious(email: String, username: String) -> User {
  User {
    email: email,
    username: username,
    active: true,
    sign_in_count: 1,
  }
}

struct Color(i32, i32, i32);

fn get_color_r(color: Color) -> i32 {
  color.0
}
