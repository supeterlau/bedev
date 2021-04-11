package main

import (
  "fmt"
  "io/ioutil"
  "net/http"
  "net/url"
  "runtime"
  "strings"
  "time"
)

type QueryResp struct {
  Addr string
  Time float64
}

func query(ip string, port string, c chan QueryResp) {
  start_ts := time.Now()
  var timeout = time.Duration(30 * time.Second)
  host := fmt.Sprintf("%s:%s", ip, port)
  url_proxy := &url.URL{Host: host}
  client := &http.Client{
    Transport: &http.Transport{Proxy: http.ProxyURL(url_proxy)},
    Timeout: timeout,
  }
  // resp, err := client.Get("http://err.taobao.com/error1.html")
  resp, err := client.Get("http://bing.com")
  if err != nil {
    fmt.Printf("Testing: %s\n", host)
    fmt.Println(err)
    c <- QueryResp{Addr: host, Time: float64(-1)}
    return
  }
  defer resp.Body.Close()
  body, _ := ioutil.ReadAll(resp.Body)
  fmt.Printf("Body: %s\n", string(body))
  time_diff := time.Now().UnixNano() - start_ts.UnixNano()
  if strings.Contains(string(body), "alibaba.com") {
    c <- QueryResp{Addr: host, Time: float64(time_diff) / 1e9}
  } else {
    c <- QueryResp{Addr: host, Time: float64(-1)}
  }
}

func main() {
  dat, _ := ioutil.ReadFile("ip.txt")
  dats := strings.Split(strings.TrimSuffix(string(dat), "\n"), "\n")

  runtime.GOMAXPROCS(4)

  resp_chan := make(chan QueryResp, 10)

  for _, addr := range dats {
    // addrs := strings.SplitN(addr, string(' '), 2)
    addrs := strings.SplitN(addr, " ", 2)
    ip, port := addrs[0], addrs[1]
    go query(ip, port, resp_chan)
  }

  for _, _ = range dats {
    r := <-resp_chan
    if r.Time > 1e-9 {
      fmt.Printf("%s %v\n", r.Addr, r.Time)
    }
  }
}

/*

strings.SplitN()

*/
