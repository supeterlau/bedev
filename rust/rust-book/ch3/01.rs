fn main() {
    // let x = 5;
    let mut x = 15;
    println!("The value of x is: {}", x);
    x = 6;
    println!("The value of x is: {}", x);

    // functions

    println!("Hello, Functions");
    another_function();

    with_parameter(30);

    let exp = 5;
    let exp2 = {
        let exp = 3;
        exp + 1
    };
    println!("exp is {}", exp);
    println!("exp2 is {}", exp2);

    println!("There is a {}", five());

    run_if();

    run_loop();

    run_while();

    run_for();
}

fn another_function() {
    println!("Another function.!");
}

fn with_parameter(x: i32) {
    println!("parameter x is {}", x);
}

fn five() -> i32 {
    // say five, haha
    5
}

fn run_if() {
    let number = 12;
    
    // #right
    // if number < 5  && number > 1 {
    
    // #wrong
    // if number < 5  & number > 1 {

    // #warning
    // if (number < 5  & number > 1) {

    if (number < 5  && number > 1) || number < 14 {
        println!("condition was true");
    } else {
        println!("condition was false");
    }

    // using if in a let Statement

    let condition = true;
    let num = if condition { 5 } else { 6 };
    // error> let num = if condition { 5 } else { "6" };
    println!("number is {}", num);
}

fn run_loop() {
    loop {
        println!("i'm looping");
        break;
    }

    // return value
    let mut counter = 0;
    let result = loop {
        counter += 1;
        if counter == 10 {
            break counter * 2;
        }
    };
    println!("result is {}", result);
}

fn run_while() {
  let mut number = 3;
  while number < 10 {
    println!("number is {}", number);
    number += 1;
  }
  println!("UP");
}

fn run_for() {
  let arr = [-1, 10, 20, 30, 50];
  let mut index = 0;
  while index < 5 {
    println!("Value is {}", arr[index]);
    index += 1;
  }

  for element in arr.iter() {
    println!("output {}", element);
  }

  // Range rev() reverse 反转 Range
  for number in (1..5).rev() {
    println!("{} get", number)
  }
}
