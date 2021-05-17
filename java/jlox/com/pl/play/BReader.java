/*
 * BReader.java
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

package com.pl.play;

import java.io.FileReader;
import java.io.BufferedReader;
// import java.lang.StackTraceElement;

import java.nio.file.Paths;

public class BReader
{
	public BReader() {
		
	}

	public static void main(String[] args) {
		String userDirectory = Paths.get("")
        .toAbsolutePath()
        .toString();
		System.out.println(userDirectory);

		char[] array = new char[100];
		String input_file = "./docker.txt";
		try {
			FileReader file = new FileReader(input_file);
			BufferedReader input = new BufferedReader(file);
			input.read(array);
			System.out.println("Data from file:");
			System.out.println(array);

			input.close();
		} catch (Exception e) {
			// StackTraceElement[] trace = e.getStackTrace();
      // System.err.println(trace[0].toString());
			e.printStackTrace();
		}
	}
}

