package main

import "fmt"

func main() {
    names := [4]string{
        "John",
        "Paul",
        "George",
        "Ringo",
    }
    fmt.Println(names)

    names1 := names[0:2]
    names2 := names[1:3]
    fmt.Println(names1, names2)

    names2[0] = "Nobody"
    fmt.Println(names1, names2)
    fmt.Println(names)
}
