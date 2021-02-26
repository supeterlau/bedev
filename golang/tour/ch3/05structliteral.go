package main

import "fmt"

type Vertex struct {
    X, Y int
}

var (
    v1 = Vertex{10, 20}
    v2 = Vertex{X: 1}
    v3 = Vertex{}
    p = &Vertex{10, 20}
)

func main() {
    fmt.Println(v1,p,v2,v3)
}
