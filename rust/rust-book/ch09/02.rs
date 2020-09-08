use std::io::ErrorKind;
use std::fs::{self, File};
use std::io::{self, Read};

fn main() {
  // let f:u32 = File::open("hello.txt");
  let f = File::open("hello.txt");
  let _f = match f {
    Ok(file) => file,
    // Err(error) => panic!("Problem opening the file: {:?}", error),
    Err(error) => match error.kind() {
      ErrorKind::NotFound => match File::create("hello.txt") {
        Ok(fc) => fc,
        Err(e) => panic!("Problem creating the file: {:?}", e),
      },
      other_error => {
        panic!("Problem opening the file: {:?}", other_error)
      }
    },
  };

  // more seasoned Rustacean
  let f = File::open("hello.txt").unwrap_or_else(|error| {
    if error.kind() == ErrorKind::NotFound {
      File::create("hello.txt").unwrap_or_else(|error| {
        panic!("Problem creating the file: {:?}", error);
      })
    } else {
      panic!("Problem opening the file: {:?}", error);
    }
  });

  // let f = File::open("hello1.txt").unwrap();

  // let f = File::open("hello1.txt").expect("Fail to open hello1.txt");

  println!("Display hello.txt :{:?}", read_from_file());
}

fn read_username_from_file() -> Result<String, io::Error> {
  let f = File::open("hello.txt");
  
  let mut f = match f {
    Ok(file) => file,
    Err(e) => return Err(e),
  };

  let mut s = String::new();

  // 返回值，尾部没有 ;
  match f.read_to_string(&mut s) {
    Ok(_) => Ok(s),
    Err(e) => Err(e),
  }
}

fn read_username_from_file_short() -> Result<String, io::Error> {
  let mut f = File::open("hello.txt")?;
  let mut s = String::new();
  f.read_to_string(&mut s)?;
  // File::open("hello.txt")?.read_to_string(&mut s)?;
  Ok(s)
}

fn read_from_file() -> Result<String, io::Error> {
  fs::read_to_string("hello.txt")
}
