package main

import (
    "fmt"
)

func fibonacci(n int, c chan int) {
    x, y := 0, 1
    for i:=0;i<n;i++ {
        c <- x
        x, y = y, x+y
    }
    // 关闭 channel
    // 类似 generator in JS
    close(c)
}

func main() {
    c := make(chan int, 10)
    // cap(c)
    go fibonacci(cap(c), c)
    for v := range c {
        fmt.Println(v)
    }
}
