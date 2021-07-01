package demo;

// Array 

import java.util.Arrays;

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
    // int[][] ints3 = new int[2][3];
    // ints3 = {1,3,5,2,4,6};
    int[][] ints3 = {{1,3,5},{2,4,6}};
    for(int i = 0; i< ints3.length; i++) {
      for (int j = 0;j<ints3[i].length; j++) {
        System.out.println("ints3["+i+"]"+"["+j+"] = "+ints3[i][j]);
      }
    }

    int[] ints4 = new int[20];
    int insertIdx = 10;
    int value = 100;
    // 高索引值全部后移一位
    for(int i=ints4.length-1;i>insertIdx;i--) {
      ints4[i] = ints4[i-1];
    }
    ints4[insertIdx] = value;
    System.out.println(Arrays.toString(ints4));
  }
}

