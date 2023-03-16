// https://www.tutorialspoint.com/fsharp/fsharp_loops.htm

// for to / for downto
// 固定次数
for i = 1 to 20 do
    printfn "i: %i" i

for i = 1 downto -20 do
    printfn "i: %i" i

// for in

let numbers = [ 10;20;30;40 ]
for i in numbers do
    printfn "i -> %d" i

// 常规 while

let mutable badw = 10

while (badw < 20) do
    printfn "Now value of badw: %d" badw
    badw <- badw + 3

// nested loop
for i = 1 to 5 do
    printf "\n"
    for j = 1 to 3 do
        printf "#"
