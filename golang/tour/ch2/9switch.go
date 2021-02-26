package main

import (
    "fmt"
    "runtime"
)

// Another important difference is that Go's switch cases need not be constants, and the values involved need not be integers.

func main() {
    // n := 3
    const n = 3
    switch n {
    case 3:
        fmt.Println("a 3")
    case 6:
        fmt.Println("a 6")
    default:
        fmt.Println("a something")
    }

    fmt.Println("Go runs on")
    switch os:=runtime.GOOS; os {
    case "darwin":
        fmt.Println("OS X.")
    case "linux":
        fmt.Println("Linux.")
    default:
        fmt.Printf("%s.\n", os)
    }
}
