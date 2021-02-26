package main

import "fmt"

var Pi = 3.14

func main() {
    const World = "世界"
    const aWorld = "One 世界"
    fmt.Println("Hello", World)
    fmt.Println("Hello", aWorld)
    fmt.Println("Happy", Pi, "Day")

    const True = true
    fmt.Println("Go with", True)

    // const False := false
    False := false
    fmt.Println("Go with", False)
}
