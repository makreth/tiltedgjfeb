class_name ItemFixedEvery extends ItemMachine

enum OperationEnum {ADD, SUBTRACT, MULTIPLY, DIVIDE, EXPONENT}
@export var operation: OperationEnum

@export
var fixedValue := 2

@onready
var _mover: ItemMover = $ItemMover as ItemMover
@onready
var _receiver: ItemReceiver = $ItemReceiver as ItemReceiver

func _ready() -> void:
	super()
	_mover.initialize(facing, [_receiver])
	_receiver.initialize(Facing.allExcept(Facing.opposite(facing)), _mover)

	match facing:
		Facing.CARDINAL.LEFT:
			$"Op Label".rotation = TAU * 0/4
		Facing.CARDINAL.DOWN:
			$"Op Label".rotation = TAU * 1/4
		Facing.CARDINAL.RIGHT:
			$"Op Label".rotation = TAU * 2/4
		Facing.CARDINAL.UP:
			$"Op Label".rotation = TAU * 3/4
		
	match operation:
		OperationEnum.ADD:
			$"Op Label".text = "+" + str(fixedValue)
		OperationEnum.SUBTRACT:
			$"Op Label".text = "-" + str(fixedValue)
		OperationEnum.MULTIPLY:
			$"Op Label".text = "x" + str(fixedValue)
		OperationEnum.DIVIDE:
			$"Op Label".text = "÷" + str(fixedValue)
		OperationEnum.EXPONENT:
			$"Op Label".text = "^" + str(fixedValue)

	_mover.setTransformFunction(func(items):
		var oldItem = items.get(0)
		var newItem = _itemClass.instantiate() as Item
		match operation:
			OperationEnum.ADD:
				newItem.value = oldItem.value + fixedValue
			OperationEnum.SUBTRACT:
				newItem.value = oldItem.value - fixedValue
			OperationEnum.MULTIPLY:
				newItem.value = oldItem.value * fixedValue
			OperationEnum.DIVIDE:
				newItem.value = oldItem.value / fixedValue
			OperationEnum.EXPONENT:
				newItem.value = oldItem.value ** fixedValue
		get_tree().current_scene.add_child(newItem)
		return newItem
	)
	self.rotate(PI / 2)
