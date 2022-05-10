import java.util.*;

class BF {
	private static Scanner scanner = new Scanner(System.in);
	private static int ptr;
	private static int length = 65535;
	private static byte memory[] = new byte[length];

	private static void interpret(String s) {
		int c = 0;
		for(int i = 0; i < s.length(); i++) {
			// move the pointer to the right
			if (s.charAt(i) == '>') {
				if(ptr == length - 1)
					ptr = 0;
				else
					ptr++;
			} else if (s.charAt(i) == '<') {
				if(ptr == 0) 
					ptr = length - 1;
				else
					ptr--;
			} else if (s.charAt(i) == '+') {
				memory[ptr]++;
			} else if (s.charAt(i) == '-') {
				memory[ptr]--;
			} else if (s.charAt(i) == '.') {
				System.out.print((char) (memory[ptr]));
			} else if (s.charAt(i) == ',') {
				memory[ptr] = (byte)(scanner.next().charAt(0));
			} else if (s.charAt(i) == '[') {
				if (memory[ptr] == 0) {
					i++;
					while( c > 0 || s.charAt(i) != ']' ) {
						if (s.charAt(i) == '[')
							// 遇到 [ 后内部 [ 数量
							c++;
						else if (s.charAt(i) == ']')
							c--;
						i++;
					}
				}
			} else if (s.charAt(i) == ']') {
				if (memory[ptr] != 0) {
					i--;
					while(c > 0 || s.charAt(i) != '[') {
						if (s.charAt(i) == ']') 
							c++;
						else if (s.charAt(i) == '[')
							c--;
						i--;
					}
					// 找到匹配的 [ 后，获取前一个指令
					i--;
				}
			}
		}
	}

	public static void main(String args[]) {
		// System.out.println(memory);
		// System.out.println("char: " + (char)memory[ptr]);
		// System.out.print("char: " + (char)memory[ptr]);

		System.out.println("Enter code: ");
		String code = scanner.nextLine();
		System.out.println("CODE: \n" + code);
		interpret(code);
	}
}
