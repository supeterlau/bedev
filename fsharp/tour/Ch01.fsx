open System

(* Multi-line comments *)

// Single-line comment

let check num =
    if num > 0 then "positive"
    elif num < 0 then "negative"
    else "zero"

let main() =
    Console.WriteLine("Check 5: {0}", (check 5))

main()
