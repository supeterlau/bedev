package demo;

import java.lang.Math;

public class Demo06 {
  public static void main(String[] args) {
    System.out.println("Hello Java!");
    if(args.length > 2) {
      System.out.println(args[0]);
      System.out.println(args[1]);
    }

    int abs1 = Math.abs(-666);
    System.out.println(abs1);

    System.out.println(Math.ceil(7.499));

    System.out.println(Math.floor(7.499));

    System.out.println(Math.floorDiv(-100, 9));

    System.out.println(Math.round(7.499));

    double degrees = Math.toDegrees(Math.PI);

    System.out.println("degrees: " + degrees);
  }
}
