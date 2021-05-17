/*
 * Scanner.java
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

package com.pl.lox;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.pl.lox.TokenType.*;

class Scanner
{
	private final String source;
	private final List<Token> tokens = new ArrayList<>();

	// keep track of where the scanner is
	private int start = 0;
	private int current = 0;
	private int line = 1;

	Scanner(String source) {
		this.source = source;
	}

	List<Token> scanTokens() {
		while (!isAtEnd) {
			// scan next lexeme
			start = current;
			scanTokens();
		}
		tokens.add(new Token(EOF, "", null, line));
		return tokens;
	}

	private void scanToken() {
		char c = advance();
		switch(c) {
			// single-character lexemes
			case '(': addToken(LEFT_PAREN); break;
			case ')': addToken(RIGHT_PAREN); break;
			case '{': addToken(LEFT_BRACE); break;
			case '}': addToken(RIGHT_BRACE); break;
			case ',': addToken(COMMA); break;
			case '.': addToken(DOT); break;
			case '-': addToken(MINUS); break;
			case '+': addToken(PLUS); break;
			case ';': addToken(SEMICOLON); break;
			case '*': addToken(STAR); break;
			case '!':
				addToken(match('=') ? BANG_EQUAL : BANG);
				break;
			case '=':
				addToken(match('=') ? EQUAL_EQUAL : EQUAL);
				break;
			case '<':
				addToken(match('=') ? LESS_EQUAL : LESS);
				break;
			case '>':
				addToken(match('=') ? GREATER_EQUAL : GREATER);
				break;
			// handle / : SLASH or Comments
			case '/':
				if (match('/')) {
					// 读取到 // 表示是注释，直到行末
					// 持续读取，直到行未和文件末 
					while (peek() != '\n' && !isAtEnd()) advance();
				} else {
					// 是 division
					addToken(SLASH);
				}
				break;
			// skip meaningless characters: newlines whitespace
			default:
				Lox.error(line,, "Unexpected character.");
				break;
		}
	}

	// Helper

	private char advance() {
		// scan next character
		return source.charAt(current++);
	}

	private boolean match(char expected) {
		// 类似 advance() 不过只在匹配输入的 expected 时才 consume
		if(isAtEnd) return false;
		if(source.charAt(current) != expected) return false;

		// consume
		current++;
		return true;
	}

	private char peek() {
		if(isAtEnd()) return '\0';
		return source.charAt(current);
	}

	private void addToken(TokenType type) {
		addToken(type, null);
	}
	
	private void addToken(TokenType type, Object literal) {
		// sub text
		String text = source.substring(start, current);
		tokens.add(new Token(type, text, literal, line));
	}

	private boolean isAtEnd() {
		return current >= source.length();
	}
}

