/*
 * Demo08.java
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

package demo;

public class Demo08
{
  public static void main(String[] args) {
		String textblock1 = """
											 This is a Java text block
											 """;

		String textblock2 = """
											 This is a Java text block
										 """;

		String textblock3 = """
											 This is a Java text block
									 """;

		System.out.println(textblock1);
		System.out.println(textblock2);
		System.out.println(textblock3);

		String[] strArray = new String[]{"uk", "usa", "jp", "fr"};
		StringBuilder temp = new StringBuilder();
		for(String s : strArray) {
			temp.append(s);
		}
		System.out.println("Concat to: "+temp.toString());

		String check = "is this good or is this bad?";
		String checker = "is";
		int checkIdx = check.indexOf(checker);
		while(checkIdx != -1) {
			System.out.println(checkIdx);
			checkIdx = check.indexOf(checker, checkIdx+1);
		}

		String reText = "one two three two one ona onb";
		System.out.println(reText.replace("one", "vcd"));
		System.out.println(reText.replaceAll("one", "vcd"));
		System.out.println(reText.replace("on*.", "vcd"));
		System.out.println(reText.replaceAll("on.?", "vcd"));
	}
}

