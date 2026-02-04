class_name Operation

enum TYPE {ADD, SUBTRACT, MULTIPLY, DIVIDE, EXPONENT, FACTORIAL, NOT, AND, OR, NAND, NOR, XOR}

static func toString(type: TYPE) -> String:
	return ["+", "-", "x", "÷", "^", "!", "¬", "∧", "∨", "⊼", "⊽", "⊻"][type]

static var factorial := func(n: int) -> int:
	var result := 1
	for i in range(2, n + 1):
		result *= i
	return result

static func getOperationFunction(type: TYPE, secondArg = 0) -> Callable:
	return [
		func(a, b = secondArg): return a + b,
		func(a, b = secondArg): return a - b,
		func(a, b = secondArg): return a * b,
		func(a, b = secondArg): return "err" if b == 0 else a / b,
		func(a, b = secondArg): return a ** b,
		func(a, _b = secondArg): return factorial.call(a),
		func(a, _b = secondArg): return int(!bool(a)),
		func(a, b = secondArg): return a && b,
		func(a, b = secondArg): return a || b,
		func(a, b = secondArg): return !(a && b),
		func(a, b = secondArg): return !(a || b),
		func(a, b = secondArg): return (!a && b) || (a && !b),
	][type]
	
