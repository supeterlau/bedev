/*
 * Demo11.java
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

package demo;
import java.util.HashMap;
import java.util.TreeMap;
import java.util.SortedMap;
import java.util.Map;

public class Demo11
{
	public Demo11() {
		
	}
	public static void main(String[] args)  {
		Map<Object, Object> map = new HashMap();

		// Super Class
		boolean mapIsObject = map instanceof Object;
		System.out.println(mapIsObject);

		// Same Class
		System.out.println(map instanceof HashMap);

		// Interface : Map
		System.out.println(map instanceof Map);

		SortedMap<Object, Object> smap = new TreeMap();
		// Superinterface : 
		System.out.println(smap instanceof TreeMap);
		if(map instanceof SortedMap) {
  		SortedMap sortedMap = (SortedMap) map;
		}
	}
}

