package main

import "golang.org/x/tour/reader"

type Awesome struct{ }

// func (a Awesome) NewReader() []byte {
//     // 数组 [1]byte{'A'}
//     return []byte{'A'}
// } 
// 
// func (a Awesome) Read(b []byte) (int, error) {
//     return len(b) ,nil
// }
// 

func (a Awesome) Read(b []byte) (int, error) {
    for i := range b {
        b[i] = 65
    }
    return len(b), nil
}
func main() {
    reader.Validate(Awesome{})
}
