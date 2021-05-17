/*
 * Scanner.java
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

package com.pl.play;

import java.util.Scanner;

public class PLScanner
{
	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);
		System.out.print("Enter name: ");

		String name = input.nextLine();

		System.out.println("Name => " + name);

		input.close();
	}
}

