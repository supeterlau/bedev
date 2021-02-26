package main

import (
    "fmt"
    "time"
)

func say(s string) {
    for i:=0;i<5;i++ {
        time.Sleep( 100 * time.Millisecond )
        if s != "Hello" {
            fmt.Println(s)
        }
    }
}

func main() {
    // go say("World")
    // say("Hello")
    go say("World")
    go say("World2")
    say("")
}
