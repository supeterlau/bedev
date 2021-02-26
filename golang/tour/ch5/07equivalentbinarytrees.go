package main

import "golang.org/x/tour/tree"

import "fmt"

func Walk(t *tree.Tree, ch chan int) {
    fmt.Println("Haha")
    if t.Left != nil {
        Walk(t.Left, ch)
    }
    ch <- t.Value
    if t.Right != nil {
        // go Walk() ???
        Walk(t.Right, ch)
    }
    // close(ch)
}

func Same(t1, t2 *tree.Tree) bool {
    v1, v2 := 0, 0
    ccap := 10
    c1 := make(chan int, ccap)
    c2 := make(chan int, ccap)
    // Walk(nil, c)
    go Walk(t1, c1)
    go Walk(t2, c2)
    for i:=0;i<ccap;i++ {
        v1 = <- c1
        v2 = <- c2
        if v1 != v2 {
            return false
        }
    }
    return true
}

func main() {
    fmt.Println("OK")
    t1 := tree.New(1)
    t2 := tree.New(1)
    result := Same(t1, t2)
    fmt.Println("t1 t2 are equal?", result)
    t1 = tree.New(1)
    t2 = tree.New(2)
    result = Same(t1, t2)
    fmt.Println("t1 t2 are equal?", result)
}
