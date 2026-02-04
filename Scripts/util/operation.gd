class_name Operation

enum TYPE {ADD, SUBTRACT, MULTIPLY, EXPONENT}

const _symbols := ["+", "-", "x", "^"]
static var _functions := [
		func(a, b): return a + b,
		func(a, b): return a - b,
		func(a, b): return a * b,
		func(a, b): return a ** b
]

static func toString(type: TYPE) -> String:
	return _symbols[type]

static func getOperationFunction(type: TYPE, secondArg = 0) -> Callable:
	return func(a, b = secondArg):
		return _functions[type].call(a, b)
	
