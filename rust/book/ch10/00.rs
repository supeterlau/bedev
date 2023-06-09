fn main() {

  let number_list = vec![34,50,25,100,65];

  let mut largest = number_list[0];

  for number in number_list {
    if number > largest {
      largest = number;
    }
  }

  println!("The largest number: {}", largest);

  let number_list = vec![34,50,25,100,65];
  println!("The largest number: {}", find_largest(&number_list));
}

fn find_largest(list: &[i32]) -> &i32 {
  let mut largest = &list[0];
  for item in list {
    if item > largest {
      largest = item;
    }
  }

  largest
}
