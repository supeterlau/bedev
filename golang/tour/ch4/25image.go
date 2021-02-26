package main

import (
    "golang.org/x/tour/pic"
    "image"
    "image/color"
)


type Image struct{
    width int
    height int
}

func (img Image) ColorModel() color.Model {
    return color.RGBAModel
}

func (img Image) Bounds() image.Rectangle {
    return image.Rect(0, 0, img.width, img.height)
}

func (img Image) At(x, y int) color.Color {
    imgFunc := func(x, y int) uint8 {
        return uint8(x ^ y)
    }
    v := imgFunc(x,y)
    return color.RGBA{v, v, 255, 255}
}

func main() {
    m := Image{100,100}
    pic.ShowImage(m)
}

// display on Mac: base64 -D test.b64 > test.jpg
// test.b64 需要删除 IMAGE: 部分
