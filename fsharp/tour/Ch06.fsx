// https://www.tutorialspoint.com/fsharp/fsharp_decision_making.htm

let test : int32 = 100

if (test = 10) then
    printfn "Value is 10\n"
elif (test = 20) then
    printfn "Value is 20\n"
else
    printfn "None of the values are match\n"
    printfn "Value is: %d" test

let b : int32 = 100
let c : int32 = 100

if (test == b) then
    printfn "test = b"
elif (test = c) then
    printfn "test = c"
else
    printfn "No match"
