package main

import (
    "fmt"
    "math"
)

type Vertex struct {
    X, Y float64
}

func (v Vertex) Abs() float64 {
    return math.Sqrt(v.X * v.X + v.Y * v.Y)
}

func Absfunc(v Vertex) float64 {
    return math.Sqrt(v.X * v.X + v.Y * v.Y)
}

func main() {
    v := Vertex{30, 40}
    fmt.Println(v.Abs())
    // 改写为 函数形式
    fmt.Println(Absfunc(v))
}
