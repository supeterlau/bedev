let check = {(val1: Int, val2: Int) -> Bool in 
	return val1 > val2
}

print(check(100,99))

let names = ["AT", "AE", "D", "S", "EB"]

var reversed = names.sorted(by: { $0 > $1 })

print(reversed)

func counter (inc amount: Int) -> () -> Int {
	var total = 0
	func incRunner() -> Int {
		total += amount 
		return total
	}
	return incRunner
}

let incByTen = counter(inc: 10)

print(incByTen())
print(incByTen())
print(incByTen())
print(incByTen())
print(incByTen())
