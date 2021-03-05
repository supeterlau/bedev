package demo;

// public class Car (need extra file)

class Car {
  private String brand;

  public Car(String theBrand) {
    this.brand = theBrand;
    // brand = theBrand;
  }

  public String getBrand() {
    return this.brand;
  }
}

public class Demo02 {

  public static void main(String[] args) {
    System.out.println("Run");
    Car car = new Car("Tesla");
    System.out.println(car.getBrand());
  }
}
