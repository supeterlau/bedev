package main

import (
    // "fmt"
    "golang.org/x/tour/wc"
    "strings"
)

func WordCount(s string) map[string]int {
    wordCount := map[string]int{}
    for _, word := range(strings.Fields(s)) {
        wordCount[word] = wordCount[word] + 1
    }
    return wordCount
}

func main() {
    // fmt.Println(WordCount("a a a b b b cc cc ddd ddd"))
    wc.Test(WordCount)
}
