class_name Operation

enum TYPE {ADD, SUBTRACT, MULTIPLY, EXPONENT}

static func toString(type: TYPE) -> String:
	return ["+", "-", "x", "^"][type]

static func getOperationFunction(type: TYPE, secondArg = 0) -> Callable:
	return [
		func(a, b = secondArg): return a + b,
		func(a, b = secondArg): return a - b,
		func(a, b = secondArg): return a * b,
		func(a, b = secondArg): return a ** b
	][type]
	
