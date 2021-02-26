package main

import (
    "fmt"
    "math"
)

type SomeFloat float64

func (f SomeFloat) Abs() float64 {
    if f < 0 {
        return float64(-f)
    }
    return float64(f)
}

func main() {
    f := SomeFloat(-math.Sqrt2)
    fmt.Println(f.Abs())
}
