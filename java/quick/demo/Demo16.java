package demo;

public class Demo16 {
  private String text = "Outer private";

  public class Inner {
    private String text = "Inner private";

    public void printText() {
      System.out.println(text);
      System.out.println(Demo16.this.text);
    }
  }

  public static void main(String[] args) {
    Demo16 demo = new Demo16();
    Demo16.Inner inner = demo.new Inner();
    inner.printText();
  }
}
