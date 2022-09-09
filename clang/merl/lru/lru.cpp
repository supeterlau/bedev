// #include <bits/stdc++.h>
// https://www.geeksforgeeks.org/lru-cache-implementation/
// https://www.delftstack.com/howto/cpp/cpp-list-vs-vector/
// https://askubuntu.com/questions/773283/how-do-i-use-c11-with-g
// https://en.cppreference.com/w/cpp/container/array

// g++ -std=c++11 -Wall -Wextra -Werror lru.cpp

#include <iostream>
#include <list>
#include <array>
#include <unordered_map>
// #include <vector>

using namespace std;

void display(list<int> l) 
{
	for (auto itr = l.begin(); itr != l.end(); itr++)
	{
		cout << *itr << " ";
	}
}

class LRUCache
{
	list<int> dq;  // doble queue
	// wrong: store ref to each key {0->dq[0], 1->dq[1]}
	// store ref to each key {dq[0]->0, dq[1]->1}
	unordered_map<int, list<int>::iterator> ma;
	int csize;  // cache size
	
	public:
		LRUCache(int);
		void refer(int);
		void print();
};

LRUCache::LRUCache(int n): csize(n) {}

void LRUCache::refer(int x)
{
	if(ma.find(x) == ma.end()) {
		// cache is full
		if((int)dq.size() == csize) 
		{
			int last = dq.back();
			dq.pop_back();
			ma.erase(last);
		}
	} else
		// 根据 index 从 dq 中移除 value 再 push_front 到 cache 头部
		dq.erase(ma[x]);
	dq.push_front(x);
	ma[x] = dq.begin();
}

void LRUCache::print() 
{
	display(dq);
}

int main()
{
	list<int> tinyList;

	tinyList.push_back(11);
	tinyList.push_back(22);
	tinyList.push_back(33);
	tinyList.push_front(44);
	display(tinyList);

	array<int, 7> arr = {12, 32, 21, 45, 61, 45, 13};
	// C++11
	// array<int, 7> arr{ {12, 32, 21, 45, 61, 45, 13} };
	int arr_len = sizeof(arr) / sizeof(arr[0]);
	cout << endl;
	cout << "Before sort:" << endl;
	for (int i = 0; i < arr_len; ++i)
	{
		cout << arr[i] << " ";
	}
	// sort(arr, arr + arr_len);
	sort(arr.begin(), arr.end());
	cout << endl;
	cout << "After sort:" << endl;
	for (int i = 0; i < arr_len; ++i)
	{
		cout << arr[i] << " ";
	}
	cout << endl;
	cout << "LRUCache Test: " << endl;

	LRUCache cache(4);

	cache.refer(11);
	cache.refer(110);
	cache.refer(1100);
	cache.refer(11000);
	cache.refer(110000);
	cache.print();
	cout << endl;

	cache.refer(11000);
	cache.print();

	return 0;
}
