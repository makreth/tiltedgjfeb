class_name Operation

enum TYPE {ADD, SUBTRACT, MULTIPLY, DIVIDE, EXPONENT, FACTORIAL, NOT, AND, OR, NAND, NOR, XOR}

const _symbols := ["+", "-", "x", "÷", "^", "!", "¬", "∧", "∨", "⊼", "⊽", "⊻"]
static var _functions := [
		func(a, b): return a + b,
		func(a, b): return a - b,
		func(a, b): return a * b,
		func(a, b): return a if b == 0 else a / b,
		func(a, b): return a ** b,
		func(a, _b): return factorial.call(a),
		func(a, _b): return int(!bool(a)),
		func(a, b): return a && b,
		func(a, b): return a || b,
		func(a, b): return !(a && b),
		func(a, b): return !(a || b),
		func(a, b): return (!a && b) || (a && !b)
]

static var factorial := func(n: int) -> int:
	var result := 1
	for i in range(2, n + 1):
		result *= i
	return result

static func toString(type: TYPE) -> String:
	return _symbols[type]

static func getOperationFunction(type: TYPE, secondArg = 0) -> Callable:
	return func(a, b = secondArg):
		return _functions[type].call(a, b)
	
