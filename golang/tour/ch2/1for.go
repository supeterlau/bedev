package main

import "fmt"

func main() {
    sum := 0
    for i:=0;i<10;i++ {
        sum+=i
    }
    fmt.Println(sum)

    fmt.Println("\nFor (2)")
    for ;sum<1000; {
        sum += sum
    }
    fmt.Println("Sum is",sum)

    fmt.Println("\nFor (3)")
    // 效果类似 while
    for sum < 2000 {
        sum += sum
    }
    fmt.Println("Sum is",sum)

    fmt.Println("一个简单的死循环")
    for {}
}
