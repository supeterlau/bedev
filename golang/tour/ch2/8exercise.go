package main

import (
    "fmt"
    "math"
)

func Sqrt(x float64) float64 {
    time := 3

    z := 1.0
    for i:=1;i<time;i++ {
        z -= (z*z - x) / (2*z)
    }
    fmt.Println(z)

    z = x
    for i:=1;i<time;i++ {
        z -= (z*z - x) / (2*z)
    }
    fmt.Println(z)

    z = x/2
    for i:=1;i<time;i++ {
        z -= (z*z - x) / (2*z)
    }
    fmt.Println(z)
    return z
}

func main() {
    fmt.Println(Sqrt(2))
    fmt.Println(math.Sqrt(2))
}

