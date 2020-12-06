use std::thread;
use std::time::Duration;

struct Cacher<T>
where
    T: Fn(u32) -> u32,
    {
      calculation: T,
      value: Option<u32>,
    }

impl<T> Cacher<T>
where
    T: Fn(u32) -> u32,
    {
      fn new(calculation: T) -> Cacher<T> {
        Cacher {
          calculation,
          value: None,
        }
      }

      fn value(&mut self, arg: u32) -> u32 {
        match self.value {
          Some(v) => v,
          None => {
            let v = (self.calculation)(arg);
            self.value = Some(v);
            v
          }
        }
      }
    }

fn main() {
  // 实际要从前端获得
  let simulated_user_specified_value = 10;
  // 用 rand crate 生成
  let simulated_random_number = 7;


  generate_workout(simulated_user_specified_value, simulated_random_number);

  let x = 4;
  // let equal_to_x = |z| z == x;
  let y = 4;
  // assert!(equal_to_x(y));
  let display = |z| {
    println!("show 1: {}", z);
    println!("show 2: {}", x);
  };
  let y = 40;
  display(y);
}

fn simulated_expensive_calculation(intensity: u32) -> u32 {
  println!("Calculating slowly...");
  thread::sleep(Duration::from_secs(2));
  intensity
}

fn generate_workout(intensity: u32, randome_number: u32) {
  // let expensive_result = simulated_expensive_calculation(intensity);

  let mut expensive_result = Cacher::new (|num| {
    println!("Calculating slowly ...");
    thread::sleep(Duration::from_secs(2));
    num
  });

  if intensity < 25 {
    println!(
      "Today, do {} pushups!",
      expensive_result.value(intensity)
    );
    println!(
      "Next, do {} situps!",
      expensive_result.value(intensity)
    );
  } else {
    if randome_number == 3 {
      println!("Take a break today! Remember to stay hydrated!");
    } else {
      println!(
        "Today, run for {} minutes!",
        expensive_result.value(intensity)
      );
    }
  }
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn call_with_different_values() {
    let mut c = Cacher::new(|a| a);
    let v1 = c.value(1);
    let v2 = c.value(2);
    assert_eq!(v2, 2);
  }
}
