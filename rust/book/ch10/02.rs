use std::fmt::Display;

pub trait Summary {
  // fn summarize(&self) -> String;

  // default implement
  fn summarize(&self) -> String {
    String::from("(Read more...)")
  }

  fn more_summarize(&self) -> String {
    format!("(Read more from {} ...)", self.summarize_author())
  }

  fn summarize_author(&self) -> String;
}

pub struct NewsArticle {
  pub headline: String,
  pub location: String,
  pub author: String,
  pub content: String,
}

// impl Summary for NewsArticle {
//   fn summarize(&self) -> String {
//     format!("{}, by {} ({})", self.headline, self.author, self.location)
//   }
// }
// 

// 使用默认方法
impl Summary for NewsArticle {
  fn summarize_author(&self) -> String {
    format!("who?")
  }
}

pub struct Tweet {
  pub username: String,
  pub content: String,
  pub reply: bool,
  pub retweet: bool,
}

// impl Summary Tweet { // error: missing `for` in a trait impl

impl Summary for Tweet {
  fn summarize(&self) -> String {
    format!("{}: {}", self.username, self.content)
  }

  // 未实现的 Trait 方法 more_summarize 会调用这个实现
  fn summarize_author(&self) -> String {
    format!("@{}", self.username)
  }
}

fn main() {
  let tweet = Tweet {
    username: String::from("news"),
    content: String::from("Many more news"),
    reply: false,
    retweet: false,
  };

  println!("1 new tweet: {}", tweet.summarize());

  let article = NewsArticle {
    headline: String::from(""),
    location: String::from(""),
    author: String::from(""),
    content: String::from(""),
  };

  println!("New article available! {}", article.summarize());

  println!("1 new tweet: {}", tweet.more_summarize());

  let pair_int = Pair::new(10, 20);
  pair_int.cmp_display();
}

// Traits as Parameters

pub fn notify(item: &impl Summary) {
  println!("Breaking news! {}", item.summarize())
}

struct Pair<T>{
  x: T,
  y: T,
}

impl<T> Pair<T> {
  fn new(x: T, y: T) -> Self {
    Self {x, y}
  }
}

impl<T: Display + PartialOrd> Pair<T> {
  fn cmp_display(&self) {
    if self.x >= self.y {
      println!("Largest member x = {}", self.x);
    } else {
      println!("Largest member y = {}", self.y);
    }
  }
}
