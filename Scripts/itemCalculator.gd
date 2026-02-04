class_name ItemCalculator extends Label

var _lockableTarget
var _inputReceivers: Array[ItemReceiver]
var _operationFunction: Callable = _no_op

static func _no_op(inputs: Array[int]) -> int:
	return inputs[0]

func initialize(lockableTarget, inputReceivers: Array[ItemReceiver], operation: Operation.TYPE, fixedSecondOperand = 0) -> void:
	_lockableTarget = lockableTarget
	_inputReceivers = inputReceivers
	_operationFunction = Operation.getOperationFunction(operation, fixedSecondOperand)
	text = Operation.toString(operation)
	if fixedSecondOperand >= 0 && !(operation == Operation.TYPE.NOT || operation == Operation.TYPE.FACTORIAL):
		text += str(fixedSecondOperand)
	ORCHESTRATOR.registerExecute(calculate, 2)
	var parent = get_parent()
	if parent is Node2D:
		rotation = -(parent as Node2D).global_rotation
		
func isLocked() -> bool:
	return _lockableTarget.isLocked() or !allReceiversFilled()

func _prepareInputsForOperation() -> Array[int]:
	var result: Array[int] = []
	for receiver in _inputReceivers:
		var currItem = receiver.getItem()
		if currItem:
			result.append(currItem.value)
	return result

func _deleteItems() -> void:
	for inputReceiver in _inputReceivers:
		inputReceiver.deleteItem()

func allReceiversFilled() -> bool:
	return _prepareInputsForOperation().size() == _inputReceivers.size()

func calculate() -> void:
	if not _lockableTarget:
		push_error("ItemTransformer must have a target to deposit the resulting Item.")
		return
	if _lockableTarget.isLocked():
		return
	if !allReceiversFilled():
		return

	var inputValues = _prepareInputsForOperation()
	var firstOperand = inputValues.get(0)
	var outputItem = _inputReceivers.get(0).getItem()
	if _inputReceivers.size() == 1:
		var resultValue = _operationFunction.call(firstOperand)
		outputItem.value = resultValue
	elif _inputReceivers.size() == 2:
		_deleteItems()
		var secondOperand = inputValues.get(1)
		var resultValue = _operationFunction.call(firstOperand, secondOperand)
		outputItem = Item.createWithScene(resultValue)
		get_tree().current_scene.add_child(outputItem)
	else:
		push_error("Invalid number of inputs: " + str(inputValues.size()))

	outputItem.global_position = _lockableTarget.global_position
