// https://www.tutorialspoint.com/fsharp/fsharp_functions.htm

// let [inline] f-name p-list : return-type
//   = f-body

open System

let cylinderVolume radius length : float = 
    let pi = 3.14159
    length * pi * radius * radius

let vol = cylinderVolume 3.0 9.0
printfn "Volume -> %g " vol

let rec fib n = if n < 2 then 1 else fib(n-1)+fib(n-2)

Console.WriteLine("fib 8 = {0}", fib 8)

let applyFunc (f: int -> int -> int) x y = f x y
let mul x y = x * y * 10
printfn "Get: %d" (applyFunc mul 8 5)

printfn "Get: %d" (applyFunc (fun x y -> x * y * 5) 8 5)

"Pipeline use |>" |> Console.WriteLine

// () 是 Unit Type

// let text () = "Backward Pipeline"

// Console.WriteLine <| text()

let makeList _ = [ for i in 1..100 -> i * 1 ]

