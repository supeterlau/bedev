package main

import "fmt"

type Vertex struct {
    X int
    Y int
}

func main() {
    v := Vertex{3, 4}
    p := &v
    p.X = 200
    fmt.Println(v)
}
