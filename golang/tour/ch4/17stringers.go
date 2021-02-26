package main

import "fmt"

type Person struct {
    Name string
    Age int
}

func (p Person) String() string {
    // Use fmt.Sprintf to format a string without printing it
    return fmt.Sprintf("%v (%v years)", p.Name, p.Age)
}

func main() {
    a := Person{"Arthur Dent", 42}
    z := Person{"Zaphod", 9000}
    fmt.Println(a, z)
}
