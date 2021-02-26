package main

import "fmt"

func fibonacci() func() int {
    first := 0
    second := 1
    return func() int {
        tmp := first
        first = second
        second = tmp + second
        return tmp
    }
}

func main() {
    f := fibonacci()
    for i:=0;i<10;i++ {
        fmt.Println(f())
    }
}
