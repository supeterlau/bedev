/*
 * Demo10.java
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

package demo;
public class Demo10
{
  public static void main(String[] args) {
    int amount = 9;
    if (amount > 9) {
      System.out.println("Amount is greater than 9.");
    } else
      System.out.println("Amount not greater than 9.");

    switch(amount+1) {
      case 0: System.out.println("Equal 0");break;
      case 10: System.out.println("Equal 10");break;
      case 20: System.out.println("Equal 20");break;
      default: System.out.println("Amount is " + amount);
    }

    for(int i=0;i<10;i++) {
      System.out.println("I is: " + i * i);
    }

    while( amount < 10 ) {
      System.out.println("Amount is " + amount);
      amount++;
    }

    printBoth("Red", "Blue");
  }

  public static void printBoth(String a, String b) {
    print(a);
    print(b);
  }

  private static void print(String text) {
    System.out.println("--> " + text);
  }
}

