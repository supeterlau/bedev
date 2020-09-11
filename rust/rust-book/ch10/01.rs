fn find_largest_i32(list: &[i32]) -> &i32 {
  let mut largest = &list[0];
  for item in list {
    if item > largest {
      largest = item;
    }
  }

  largest
}

fn find_largest_char(list: &[char]) -> &char {
  let mut largest = &list[0];
  for item in list {
    if item > largest {
      largest = item;
    }
  }

  largest
}

// 添加 trait bound
// PartialOrd 

fn find_largest_copy<T: PartialOrd + Copy>(list: &[T]) -> T {
  let mut largest = list[0];

  for &item in list {
    if item > largest {
      largest = item;
    }
  }

  largest
}

fn find_largest_clone<T: PartialOrd+Clone>(list: &[T]) -> T {
  let inner_list = list.clone();
  let mut largest = list[0].clone();

  for item in inner_list {
    if item > &largest {
      largest = item.clone();
    }
  }

  largest
}

fn find_largest_ref<T: PartialOrd>(list: &[T]) -> &T {
  let mut largest = &list[0];
  for item in list {
    if item > largest {
      largest = item;
    }
  }

  largest
}

struct Point<T> {
  x: T,
  y: T,
}

enum OwnResult<T, E> {
  Ok(T),
  Err(E),
}

impl<T> Point<T> {
  fn x(&self) -> &T {
    &self.x
  }
}

fn main() {
  let number_list = vec![34,50,20,35,67,39];
  let result = find_largest_i32(&number_list);
  println!("The largest i32 number: {}", result);

  let char_list = vec!['y', 'm','a','q'];
  let result = find_largest_char(&char_list);
  println!("The largest char: {}", result);

  let char_list = vec!['y','m','a','q','z'];
  // let result = find_largest(&char_list);
  let result = find_largest_copy(&char_list);
  println!("The largest char (Copy): {}", result);

  let result = find_largest_clone(&char_list);
  println!("The largest char (Clone): {}", result);

  let result = find_largest_ref(&char_list);
  println!("The largest char (ref): {}", result);

  let integer_point = Point {x: 5, y: 10};
  let float_point = Point {x: 1.01, y: 3.07};

}
