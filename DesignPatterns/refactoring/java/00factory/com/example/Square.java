package com.example;

// concrete class
// 实现接口方法的类

public class Square implements Shape {
  @Override
  public void draw() {
    System.out.println("Inside Square::draw() method");
  }
}
