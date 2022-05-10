import java.util.*;

class IO {
	public static void main(String args[]) {
		Scanner scanner = new Scanner(System.in);
		String text = scanner.nextLine();
		System.out.println("IN: " + text);
		char c = scanner.next().charAt(0);
		System.out.println("IN Char: " + c);
	}
}
