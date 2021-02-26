package main

import (
  "bytes"
  "fmt"
)

func main() {
  var b bytes.Buffer
  for i := 0; i < 1000; i++ {
    b.WriteString(randString())
  }
  fmt.Println(b.String())
  fmt.Println("abc" + "-" + "xyz")
}

func randString() string {
  return "abc-xyz-"
}
