package main

import "fmt"

func main() {
    defer fmt.Println("World")

    a := 1
    b := 2
    defer fmt.Println("defer:", a+b)
    a ++
    b += 4
    fmt.Println("immediately:", a+b)
    
    fmt.Println("Hello")
}
