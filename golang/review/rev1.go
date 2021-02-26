package main

import (
	"fmt"
	"math/rand"
	"time"
)

func main() {
	rand.Seed(1234)
	fmt.Println(rand.Intn(100))
	fmt.Println("Time now: ", time.Now())
	split(30)

	var iint = 1
	jint := 100
	fmt.Println("Yes: ", iint, jint)

	// Flow Control
	big := 123
	if small := 122; small > big {
		fmt.Print("I'm big")
	} else {
		fmt.Println("I'm small")
	}

	username := "Flower"
	switch username {
	case "Flower":
		fmt.Print("You are flower")
	case "Color":
		fmt.Print("You are color")
	default:
		fmt.Print("Who r u?")
	}
	fmt.Println("")

	// Pointer
	namei := "Luck"
	namej := "Happy"
	nameip := &namei
	fmt.Println("namei value: ", *nameip)
	fmt.Printf("%q \n", nameip)
	*nameip = namej
	fmt.Println("namei value: ", *nameip)

	// Struct
	bigV := Vertex{233, 996}
	fmt.Println("Vertex bigV.X = ", bigV.X)
	bigVp := &bigV
	bigVp.X = 798
	fmt.Println("Vertex bigV.X = ", bigV.X)
	fmt.Println("Vertex bigV.Y = ", bigVp.Y)

	// Arrays & Slices
	phoneArray := [3]string{"huawei", "xiaomi", "oppo"}
	fmt.Println("Phone brand", phoneArray[0], phoneArray[1], phoneArray[2])
	var firstTwo = phoneArray[0:2]
	fmt.Println("firstTwo cap: ", cap(firstTwo), " length: ", len(firstTwo))

	//	use make
	newArr := make([]int, 5, 8) // len: 5, cap: 8
	newArr[1] = 101
	newArr = append(newArr, 108)
	fmt.Println("second of newArr: ", newArr[1])
	fmt.Println("last elem: ", newArr[len(newArr)-1])

	for i, v := range newArr {
		fmt.Println("Index: ", i, " -> Value: ", v)
	}

	// Maps
	literalMap := map[string]Vertex{
		"firstV": {
			102,
			103,
		},
		"secondV": {
			190,
			191,
		},
	}
	fmt.Println("FirstV: ", literalMap["firstV"])
	secondElem, ok := literalMap["secondV"]
	if ok {
		fmt.Println("SecondV => ", secondElem)
	}

	fmt.Println("use (add 200): ", adder200()(101))

	// Methods
	v7 := Vertex{900, 899}
	fmt.Println("Check v7: ", v7.bigger())

	v7.Double()
	fmt.Println("Check v7 after double: ", v7)
	v7p := &v7
	v7p.Double()
	fmt.Println("Check v7 after double: ", v7)
}

func split(sum int) (x, y int) {
	x = 1
	y = 1
	fmt.Println(x, y)
	return
}

// Struct
type Vertex struct {
	X int
	Y int
}

func adder200() func(int) int {
	sum := 200
	return func(x int) int {
		sum += x
		return sum
	}
}

// Method
// method 对 type 定义的类型通用
// type MyFload float64

func (v Vertex) bigger() int {
	if v.X > v.Y {
		fmt.Println("X is bigger")
		return 1
	} else if v.X < v.Y {
		fmt.Println("Y is bigger")
		return -1
	} else {
		fmt.Println("X and Y are Equal")
		return 0
	}
}

// (v Vertext) 部分叫 receiver 可以是指针，此时可以修改 receiver 中的值

func (v *Vertex) Double() {
	v.X *= 2
	v.Y *= 2
}

// Interface
// 类型实现一种 interface 只需要实现定义的方法即可。不需要 implement 关键字指定
