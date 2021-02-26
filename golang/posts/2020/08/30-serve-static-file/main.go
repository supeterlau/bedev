package main

import (
  "log"
  "net/http"
  "os"
  // s "strings"
)

func main() {
  fs := http.FileServer(http.Dir("./static"))
  port, exists := os.LookupEnv("PORT")
  if !exists {
    port = "3000"
  }
  http.Handle("/", fs)

  log.Printf("Listening on http://localhost:%s...\n", port)
  err := http.ListenAndServe("0.0.0.0:"+port, nil)
  if err != nil {
    log.Fatal(err)
  }
}

