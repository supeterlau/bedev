package main

import "fmt"

func main() {
    i, j := 42, 2701

    p := &i  // i 的指针 p
    fmt.Println(*p)  // 通过指针读取 i 的值
    *p = 21  // 通过指针赋值
    fmt.Println(i)

    p = &j
    *p = *p/37
    fmt.Println(j)
}
