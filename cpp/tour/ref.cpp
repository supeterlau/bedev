/*
 * ref.cpp
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "ref.h" */

#include <iostream>
#include <cstring>

using namespace std;

typedef struct {
  char title[50];
  char author[50];
  char subject[100];
  int book_id;
} Book;

void printBookbyv( Book book );
void printBookbyp( Book *book );
void printBookbyr( Book &book );

int main() {
  int i;
  double d;

  int &r = i;  // int& r = i;
  double &s = d;

  i = 5;
  cout << "Value of i: " << i << endl;
  cout << "Value of i reference: " << r << endl;

  d = 11.7;
  cout << "Value of d: " << d << endl;
  cout << "Value of d reference: " << s << endl;

  // ref of struct
  Book book1;
  Book book2;

  strcpy(book1.title, "The Little Scheme");
  strcpy(book1.author, "D.F");
  strcpy(book1.subject, "Learn Scheme");
  book1.book_id = 1000;

  strcpy(book2.title, "The Good Scheme");
  strcpy(book2.author, "D.F.N");
  strcpy(book2.subject, "Learn Scheme for Good");
  book2.book_id = 1002;

  cout << "Before title: " << book1.title << endl;
  printBookbyv(book1);
  /* printBookbyv(book2); */

  cout << "After title: " << book1.title << endl;
  strcpy(book1.title, "The Little Scheme");

  cout << "Before title: " << book1.title << endl;

  printBookbyp(&book1);
  /* printBookbyp(&book2); */

  cout << "After title: " << book1.title << endl;
  strcpy(book1.title, "The Little Scheme");

  cout << "Before title: " << book1.title << endl;

  Book &br1 = book1;
  /* Book &br2 = book2; */
  printBookbyr(br1);
  cout << "After title: " << book1.title << endl;
  strcpy(book1.title, "The Little Scheme");
  /* printBookbyr(br2); */

  return 0;
}

void printBookbyv(Book book) {
  strcpy(book.title, "JavaScript");
  /* cout << "=== By Value ===" << endl; */
  /* cout << "Book title: " << book.title << endl; */
  /* cout << "Book author: " << book.author << endl; */
  /* cout << "Book subject: " << book.subject << endl; */
  /* cout << "Book book_id: " << book.book_id << endl; */
  /* cout << endl; */
}

void printBookbyp(Book *book) {
  strcpy(book->title, "JavaScript");
  /* cout << "=== By Pointer ===" << endl; */
  /* cout << "Book title: " << book->title << endl; */
  /* cout << "Book author: " << book->author << endl; */
  /* cout << "Book subject: " << book->subject << endl; */
  /* cout << "Book book_id: " << book->book_id << endl; */
  /* cout << endl; */
}
void printBookbyr(Book &book) {
  strcpy(book.title, "JavaScript");
  /* cout << "=== By Reference ===" << endl; */
  /* cout << "Book title: " << book.title << endl; */
  /* cout << "Book author: " << book.author << endl; */
  /* cout << "Book subject: " << book.subject << endl; */
  /* cout << "Book book_id: " << book.book_id << endl; */
  /* cout << endl; */
}
