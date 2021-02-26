package main

import (
    "fmt"
    "math"
)

type Abser interface {
    Abs() float64
    // 一个无参数，返回 float64 的方法
}

type SomeFloat float64

func (f SomeFloat) Abs() float64 {
    if f < 0 {
        return float64(-f)
    }
    return float64(f)
}

type Vertex struct {
    X, Y float64
}

func (v *Vertex) Abs() float64 {
    return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func main() {
    // interface 是一个类型
    var a Abser
    f := SomeFloat(-math.Sqrt2)
    v := Vertex{3,4}

    a = f
    fmt.Println(a.Abs())
    a = &v
    fmt.Println(a.Abs())
    // a = v
    // fmt.Println(a.Abs())
}
