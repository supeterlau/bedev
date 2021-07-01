package demo;

public class Demo12 {
  public static void main(String[] args) {
    Car12 car1 = new Car12();
    Car12 car2 = new Car12();
    Car12 car3 = new Car12();

    car1.setColor("red");
    car2.setColor("green");
    car3.setColor("blue");

    car1.info();
    car2.info();
    car3.info();
  }
}

