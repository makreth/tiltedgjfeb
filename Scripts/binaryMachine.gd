class_name ItemBinaryAdd extends ItemMachine

@onready
var _transporter: ItemTransporter = $ItemTransporter as ItemTransporter
@onready
var _receiver1: ItemReceiver = $ItemReceiver1 as ItemReceiver
@onready
var _receiver2: ItemReceiver = $ItemReceiver2 as ItemReceiver
@onready
var _calculator: ItemCalculator = $ItemCalculator as ItemCalculator


func _ready() -> void:
	super()
	_transporter.initializeWithNewFacing(facing)
	var transportReceiver: ItemReceiver = _transporter.getReceiver()
	_calculator.initialize(transportReceiver, [_receiver1, _receiver2], operation)
	_receiver1.initialize(Facing.all(), _calculator)
	_receiver2.initialize(Facing.all(), _calculator)
