package main

import (
    "fmt"
    "sync"
    "time"
)

type SafeCounter struct {
    v map[string]int
    mux sync.Mutex
}

func (c *SafeCounter) Inc(key string) {
    // add goroutine lock
    c.mux.Lock()
    c.v[key]++
    c.mux.Unlock()
}

func mut(s *int, add int) {
    *s += add
}

func (c *SafeCounter) Value(key string) int {
    a := 1
    c.mux.Lock()
    defer fmt.Println("After Unlock and Mut...")
    defer c.mux.Unlock()
    mut(&a, 10)
    mut(&a, 10)
    // defer mut(&a, 10)
    defer fmt.Println("Before Unlock and Mut...")
    // defer arr[2] = 5
    // return c.v[key]
    return a
}

func main() {
    c := SafeCounter{v: make(map[string]int)}
    for i:=0;i<1000;i++ {
        go c.Inc("Somekey")
    }
    time.Sleep(time.Second)
    fmt.Println(c.Value("Somekey"))
}
