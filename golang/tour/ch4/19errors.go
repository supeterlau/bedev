package main

import (
    "fmt"
    "time"
)

type BigError struct {
    When time.Time
    What string
}

func (e *BigError) Error() string {
    return fmt.Sprintf("at %v, %s", e.When, e.What)
}

func run() error {
    return &BigError{
        time.Now(),
        "it didn't work",
    }
}

func main() {
    if err := run(); err != nil {
        fmt.Println(err)
    }
}
