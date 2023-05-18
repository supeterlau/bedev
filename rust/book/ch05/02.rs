#[derive(Debug)]

struct Rectangle {
  width: u32,
  height: u32,
}

fn main() {
  let width1 = 30;
  let height1 = 50;

  println!(
    "use Params: The area of recctangle is {} square pixels",
    area_params(width1, height1)
  );

  let rect1 = (30,50);
  
  println!(
    "use Tuple: The area of recctangle is {} square pixels",
    area_tuple(rect1)
  );

  let rect2 = Rectangle {
    width: 30,
    height: 50,
  };
  
  println!(
    "use Struct: The area of recctangle is {} square pixels",
    area_struct(&rect2)
  );

  // println!("rect2 is {}", rect2);
  println!("rect2 is {:?}", rect2);
  println!("rect2 is {:#?}", rect2);
  
}

fn area_params(width: u32, height:u32) -> u32 {
  width * height
}

fn area_tuple(dimensions: (u32, u32)) -> u32 {
  dimensions.0 * dimensions.1
}

// 使用 borrow 形式
fn area_struct(rectangle: &Rectangle) -> u32 {
  rectangle.width * rectangle.height
}
