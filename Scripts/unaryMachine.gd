class_name UnaryMachine extends ItemMachine

@export
var fixedValue := 1

@onready
var _transporter: ItemTransporter = $ItemTransporter as ItemTransporter
@onready
var _receiver: ItemReceiver = $ItemReceiver as ItemReceiver
@onready
var _calculator: ItemCalculator = $ItemCalculator as ItemCalculator

func _ready() -> void:
	super()
	self.rotate(PI / 2)
	_transporter.initializeWithNewFacing(facing)
	var transportReceiver: ItemReceiver = _transporter.getReceiver()
	_receiver.initialize(Facing.allExcept(Facing.opposite(facing)), _calculator)
	_calculator.initialize(transportReceiver, [_receiver], operation, fixedValue)
