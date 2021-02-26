package main

import "fmt"

type Vertex struct {
    Lat, Lng float64
}

var m map[string]Vertex

func main() {
    m = make(map[string]Vertex)
    m["Bell Labs"] = Vertex{
        40.68433, -74.39967,
        // 末尾 ,
    }
    fmt.Println(m["Bell Labs"])
}
