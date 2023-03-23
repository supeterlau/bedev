/*
 * App01.java
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

public class App01
{
	public App01() {
	}

	public static void main(String[] args) {
		Vehicle v1 = new Vehicle();
		v1.setColor("RED");
		System.out.println(v1.getColor());
	}
}

