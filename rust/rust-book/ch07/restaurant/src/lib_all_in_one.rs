// #[cfg(test)]

mod front_of_house {
  // mod hosting {
  pub mod hosting {
    pub fn add_to_waitlist() {
      println!("Hi, add_to_waitlist");
    }
    fn seat_at_table() {
      println!("Hi, seat_at_table");
    }
  }

  mod serving {
    fn take_order() {
      println!("Hi, take_order");
    }
    
    fn serve_order() {
      println!("Hi, serve_order");
    }

    fn take_payment() {
      println!("Hi, take_payment");
    }
  }
}

use crate::front_of_house::hosting;
use self::front_of_house::serving;

pub fn eat_at_restaurant() {
  crate::front_of_house::hosting::add_to_waitlist();

  front_of_house::hosting::add_to_waitlist();

  let mut meal = back_of_house::Breakfast::summer("Rye");

  meal.toast = String::from("Wheat");
  println!("I'd linke {} toast please", meal.toast);

  // meal.seasonal_fruit = String::from("blueberries");
  
  let order1 = back_of_house::Appetizer::Soup;
  let order2 = back_of_house::Appetizer::Salad;
  println!("order1 {:?}", order1);
  println!("order2 {:?}", order2);

  hosting::add_to_waitlist();
  hosting::add_to_waitlist();
  hosting::add_to_waitlist();
}

fn serve_order() {
  println!("serve_order in crate");
}

mod back_of_house {
  fn fix_incorrect_order() {
    cook_order();
    super::serve_order();
  }

  fn cook_order() {
    println!("cook_order");
  }

  pub struct Breakfast {
    pub toast: String,
    seasonal_fruit: String,
  }

  impl Breakfast {
    pub fn summer(toast: &str) -> Breakfast {
      Breakfast {
        toast: String::from(toast),
        seasonal_fruit: String::from("peaches"),
      }
    }
  }

  #[derive(Debug)]
  pub enum Appetizer {
    Soup,
    Salad,
  }
}

/*
use std::fmt;
use std::io;

fn function1() -> fmt::Result {

}

fn function2() -> io::Result {

}

use rand::Rng;

fn main() {
  let secret_number = rand::thread_rng().gen_range(1, 101);
}
*/
