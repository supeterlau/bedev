package demo;

public class Car12 {
  public String brand = null;
  public String model = null;
  public String color = null;

  public Car12() {
    this.brand = "Brand";
    this.model = "Model";
    this.color = "Color";
  }

  public Car12(String brand, String model, String color) {
    this.brand = brand;
    this.model = model;
    this.color = color;
  }

  public void setColor(String newColor) {
    this.color = newColor;
  }

  // private void info() {
  // public void info() {
  protected void info() {
    System.out.println("Color: "+this.color+" | Brand: "+this.brand+" | Model: " + this.model);
  }

  public static class Color {

  }
}
