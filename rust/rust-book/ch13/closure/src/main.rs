use std::thread;
use std::time::Duration;

fn main() {
  // 实际要从前端获得
  let simulated_user_specified_value = 10;
  // 用 rand crate 生成
  let simulated_random_number = 7;

  generate_workout(simulated_user_specified_value, simulated_random_number);
}

fn simulated_expensive_calculation(intensity: u32) -> u32 {
  println("Calculating slowly...");
  thread::sleep(Duration::from_secs(2));
  intensity
}

fn generate_workout(intensity: u32, randome_number: u32) {
  if intensity < 25 {
    println!(
      "Today, do {} pushups!",
      simulated_expensive_calculation(intensity)
    );
    println!(
      "Next, do {} situps!",
      simulated_expensive_calculation(intensity)
    );
  } else {
    if randome_number == 3 {
      println!("Take a break today! Remember to stay hydrated!");
    } else {
      println!(
        "Today, run for {} minutes!",
        simulated_expensive_calculation(intensity)
      );
    }
  }
}
