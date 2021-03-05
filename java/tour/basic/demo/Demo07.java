package demo;

// Array 

public class Demo07 {
  public static void main(String[] args) {
    System.out.println("Hello Java!");
    if(args.length > 2) {
      System.out.println(args[0]);
      System.out.println(args[1]);
    }

    int[] intArray;
    intArray = new int[10];

    // int[] ints2 = new int[]{1,2,3,4,5};
    int[] ints2 = {1,2,3,4,5};

    System.out.println("ints2 length: " + ints2.length);
  }
}

