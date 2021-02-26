package main

import (
  "fmt"
)

func main() {
  s := make([]string, 3)
  fmt.Println("emp:", s)

  s[0] = "a"
  s[1] = "w"
  s[2] = "k"
  fmt.Println("set:", s)
  fmt.Println("get:", s[2])

  fmt.Println("len:", len(s))

  s = append(s, "d")
  s = append(s, "a", "n")
  fmt.Println("apd:", s)

  c := make([]string, len(s))
  copy(c, s)
  fmt.Println("cpy:", c)

  l := s[2:5]
  fmt.Println("slice:", l)

  l = s[:5]
  fmt.Println("slice:", l)

  l = s[2:]
  fmt.Println("slice:", l)

  // 字面量赋值
  t := []string{"s", "k", "y"}
  fmt.Println("define:", t)

  twoD := make([][]int, 3)
  for i := 0; i < 3; i++ {
    innerLen := i + 1
    twoD[i] = make([]int, innerLen)
    for j := 0; j < innerLen; j++ {
      twoD[i][j] = i + j
    }
  }
  fmt.Println("2d: ", twoD)
}
