package main

import "fmt"

func sum(s []int, c chan int) {
    fmt.Printf("run sum though: %q\n", c)
    sum := 0
    for _, v := range s {
        sum += v
    }
    c <- sum  // send sum to channel
}

func main() {
    s := []int{7,2,8,-9, 11,4}

    c := make(chan int)
    go sum(s[:len(s)/2], c)
    go sum(s[len(s)/2:], c)
    // sum 何时执行的?
    fmt.Println("Get result Back...")  // 接收数据时执行 sum
    x, y := <-c, <-c

    fmt.Println("Print result")
    fmt.Println(x, y, x + y)
    fmt.Println("channel cap:", cap(c))

    test := []int{1,2,3,4,5}
    for i, v := range test {
        fmt.Println(i, v)
    }
}
