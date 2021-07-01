/*
 * Demo09.java
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

package demo;
public class Demo09
{
	private static enum Size {
		MINI,
		SMALL,
		MEDIUM,
		LARGE,
		X_LARGE
	}
	public static void main(String[] args) {
		switchOnEnum(Size.X_LARGE);
		switchOnEnum(Size.MINI);
	}
	private static void switchOnEnum(Size size) {
		switch(size) {
			case SMALL : {System.out.println("size: small"); break;}
			case MEDIUM: {System.out.println("size: medium"); break;}
			case LARGE:
			case X_LARGE: {System.out.println("size: large");break;}
			default: {System.out.println("size is not S,M,L or XL: "+size);}
		}
	}
}

