package main

import "fmt"

// https://golangbyexample.com/pointer-vs-value-receiver-method-golang/
// https://blog.logrocket.com/exploring-structs-and-interfaces-in-go/

// struct interface 都要用 type 声明

// 其他 type type UserName string 就是 type alias

// 变量为类型为接口时，需要实现全部接口需要的函数才行
// 指针接受者方法只能指针类型使用
// 值接受者方法都可以使用

type info interface {
  Info() string
  Show() string
}

type person struct {
  name string
  age int
}

func NewPerson(name string, age int) *person {
  p := new(person)
  p.name = name
  p.age = age
  return p
}

func (p person) Info() string {
  return fmt.Sprintf("person name: %s age: %d", p.name, p.age)
}

func (p *person) Show() string {
  return fmt.Sprintf("via Pointer -> person name: %s age: %d", p.name, p.age)
}

func main() {
  var name *string
  name = new(string)
  *name = "John"
  fmt.Printf("name = %v\n", *name)

  p := NewPerson("John", 18)
  fmt.Printf("name = %s, \nage = %d\n", p.name, p.age)
  fmt.Printf("p = %v\n", p)

  fmt.Println( p.Info())
  fmt.Println( p.Show())

  pv := person{"Mike", 12}
  fmt.Printf("pv = %v\n", pv)
  fmt.Println(pv.Show())

  var ip info
  ip = person{"Aya", 10}
  fmt.Printf(ip.Show)

  var a animal

  a = lion{age : 3}
  a.breathe()
  // a.walk()

  a = &lion{age: 5}
  a.breathe()
  // a.walk()
}

type animal interface {
  breathe()
  walk()
}

type lion struct {
  age int
}

// func (l lion) breathe() {
func (l lion) breathe() {
  fmt.Println("Lion breathes")
}

func (l *lion) walk() {
  fmt.Println("Lion walks")
}

// type 组合
type iCar interface {
  speed() string
  move() string
}

type iBoat interface {
  ship() string
  windSpeed() string
}

type iCarBoat interface {
  iCar
  iBoat
}
