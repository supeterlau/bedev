package main

import "fmt"

// func sum(a, b int) {}

func fibonacci(c, quit chan int) {
    fmt.Println("Run fibonacci")
    x, y := 0, 1
    for {
        select {
        case c <- x:
            x,y = y,x+y
        case <- quit:
            fmt.Println("quit")
            return
        }
    }
}

func main() {
    c := make(chan int)
    quit := make(chan int)
    go func() {
        fmt.Println("Run goroutine")
        for i:=0;i<10;i++ {
            fmt.Println(<-c)
        }
        quit <- 0
    }()
    fibonacci(c, quit)
}
