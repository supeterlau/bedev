fn main() {
  let text = String::from("Hello Slice");
  println!("Find in text: {}", first_word(&text));

  let mut mut_text = String::from("Good Day");
  let word_end = first_word(&mut_text);
  mut_text.clear();
  println!("Word end : {}", word_end);

  // string slice

  let mut slice_word = String::from("Handling UTF-8 mutable");
  let slice = first_word_slice(&mut slice_word);
  println!("Get slice: {}", slice);

  // error:
  // slice_word.clear();
  // println!("Get slice: {}", slice);

  let second_slice = second_word_slice(&slice_word);
  println!("Get slice: {}", second_slice);

  // ok:
  // let slice_as_param = first_word_slice_param(&mut slice_word);
  // let slice_as_param = first_word_slice_param(&slice_word);
  // let slice_as_param = first_word_slice_param(&slice_word[..]);
  let slice_as_param = first_word_slice_param("Hi Rust");
  println!("Get slice: {}", slice_as_param);
}

fn first_word(s: &String) -> usize {
  let bytes = s.as_bytes();

  // for (i, item) in bytes.iter().enumerate() {
  //   if *item == b' ' {

  for (i, &item) in bytes.iter().enumerate() {
    if item == b' ' {
      return i;
    }
  }
  s.len()
}

// String Slice 类型 &str
fn first_word_slice(s: &mut String) -> &str {
  let bytes = s.as_bytes();

  for (i, &item) in bytes.iter().enumerate() {
    if item == b' ' {
      return &s[0..i];
    }
  }
  &s[..]
}

// second : 
//   save index in array ? 
//   use count

fn second_word_slice(s: &String) -> &str {
  let bytes = s.as_bytes();
  let mut start = 0;

  for (i, &item) in bytes.iter().enumerate() {
    if item == b' ' {
      if start == 0 {
        start = i+1;
      } else {
        return &s[start..i];
      }
    }
  }
  if start != 0 {
    return &s[start..];
  }
  &s[..]
}

fn first_word_slice_param(s: &str) -> &str {
  let bytes = s.as_bytes();

  for (i, &item) in bytes.iter().enumerate() {
    if item == b' ' {
      return &s[0..i];
    }
  }
  &s[..]
}
