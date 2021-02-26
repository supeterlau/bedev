package main

import "fmt"

type I interface {
    M()
    MP()
}

type T struct {
    S string
}

func (t *T) M() {
    fmt.Println(t.S)
}

func (t *T) MP() {
    fmt.Println(t.S, "OK", t.S)
}

func main() {
// func (t T) M() {
//     fmt.Println(t.S)
// }
// func (t T) MP() {
//     fmt.Println(t.S, "OK", t.S)
// }
    // var i I = &T{"Hello"}  // ok
    // var i I = T{"Hello"}  // ok

// func (t *T) M() {
//     fmt.Println(t.S)
// }
// 
// func (t T) MP() {
//     fmt.Println(t.S, "OK", t.S)
// }
    // var i I = T{"Hello"}  // error
    // var i I = &T{"Hello"}  // ok

// func (t *T) M() {
//     fmt.Println(t.S)
// }
// 
// func (t *T) MP() {
//     fmt.Println(t.S, "OK", t.S)
// }
    // var i I = T{"Hello"}  // error
    var i I = &T{"Hello"}  // error
    i.M()
    i.MP()
}
