// mod hosting 
pub mod hosting;

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
