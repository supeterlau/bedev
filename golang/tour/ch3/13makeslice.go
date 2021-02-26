package main

import "fmt"

func main() {
    first := make([]int, 5)
    printSlice("first:", first)

    second := make([]int, 0, 5)
    printSlice("second:", second)

    third := second[:2]
    printSlice("third:", third)

    forth := third[2:5]
    printSlice("forth:", forth)
}

func printSlice(s string, x []int) {
    fmt.Printf("%s len=%d cap=%d %v\n", s, len(x), cap(x), x)
}
