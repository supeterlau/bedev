package main

import (
    "io"
    "os"
    "strings"
    "fmt")

type rot13Reader struct {
    r io.Reader
}

func convert(b byte) byte {
    switch {
    case (b >= 65 && b <= 77) || (b >= 97 && b <= 109):
        return b + 13
    case (b > 77 && b <= 90) || (b > 109 && b <= 122):
        return b - 13
    default:
        return b
    }
    // if b
}

func (r *rot13Reader) Read(b []byte) (int, error) {
    n, err := r.r.Read(b)
    fmt.Println("\nLength: ", n)
    for i:=0;i<n;i++ {
        b[i] = convert(b[i])
    }
    return n, err
    // fmt.Println(b)
    // r.Read
    // if len(b) > 0 {
    //     for i, v := range b {
    //         b[i] = convert(v)
    //     }
    //     return len(b), nil
    // }
    // return 0, io.EOF
}

func main() {
    // s := strings.NewReader("Lbh penpxrq gur pbqr!")

    // s := strings.NewReader("A stupid bear!haha")
    s := strings.NewReader("N fghcvq orne!unun")
    r := rot13Reader{s}
    io.Copy(os.Stdout, &r)
    // for i:=65;i<100;i++ {
        // fmt.Printf("%c\n", i)
    // }
}
