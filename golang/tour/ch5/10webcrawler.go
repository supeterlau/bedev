package main

import (
    "fmt"
    "sync"
)

type Fetcher interface {
    Fetch(url string) (body string, urls []string, err error)
}

func Crawl0(url string, depth int, fetcher Fetcher) {
    //
    if depth <= 0 {
        return
    }
    body, urls, err := fetcher.Fetch(url)
    if err != nil {
        fmt.Println(err)
        return
    }
    fmt.Printf("found: %s %q\n", url, body)
    for _, u := range urls {
        Crawl0(u, depth-1, fetcher)
    }
    return
}

type safeCache struct {
    cache map[string]bool
    mux sync.Mutex
}

func Crawl(s safeCache, url string, depth int, fetcher Fetcher, wg *sync.WaitGroup) {
    defer wg.Done()

    // fmt.Println("The url:", url)
    if depth <= 0 {
        return
    }
    s.mux.Lock()
    _, ok := s.cache[url]
    s.mux.Unlock()
    if ok {
        return
    }
    // fmt.Println("The url:", url)
    body, urls, err := fetcher.Fetch(url)
    s.mux.Lock()
    s.cache[url] = true
    s.mux.Unlock()
    if err != nil {
        fmt.Println(err)
        return
    }
    fmt.Printf("found: %s %q\n", url, body)
    for _, u := range urls {
        wg.Add(1)
        // fmt.Println(u)
        go Crawl(s, u, depth-1, fetcher, wg)
    }
    return
}

func main() {
    s := safeCache{
        cache: make(map[string]bool),
    }
    wg := &sync.WaitGroup{}
    wg.Add(1)

    Crawl(s, "https://golang.org/", 4, fetcher, wg)
    
    wg.Wait()
}

type fakeFetcher map[string]*fakeResult

type fakeResult struct {
    body string
    urls []string
}

func (f fakeFetcher) Fetch(url string) (string, []string, error) {
    if res, ok := f[url]; ok {
        return res.body, res.urls, nil
    }
    return "", nil, fmt.Errorf("[Error] not found: %s", url)
}

var fetcher = fakeFetcher{
    "https://golang.org/": &fakeResult{
        "The Go Programming Language",
        []string{
            "https://golang.org/pkg/",
            "https://golang.org/cmd/",
        },
    },
    "https://golang.org/pkg/": &fakeResult{
        "Packages",
        []string{
            "https://golang.org/",
            "https://golang.org/cmd/",
            "https://golang.org/pkg/fmt/",
            "https://golang.org/pkg/os/",
        },
    },
    "https://golang.org/pkg/fmt/": &fakeResult{
        "Package fmt",
        []string{
            "https://golang.org/",
            "https://golang.org/pkg/",
        },
    },
    "https://golang.org/pkg/os/": &fakeResult{
        "Package os",
        []string{
            "https://golang.org/",
            "https://golang.org/pkg/",
        },
    },
}

// https://github.com/golang/go/issues/13110
// 想到用 sync.Mutex 和 sync.WaitGroup
// 可以用 channel
// 可以基于 sync.Mutex 实现自己的 sync.WaitGroup
// 主线程先结束，导致子线程结果无法显示出来

// https://gist.github.com/harryhare/6a4979aa7f8b90db6cbc74400d0beb49
