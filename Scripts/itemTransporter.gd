class_name ItemTransporter extends ItemMachine

@onready
var _mover: ItemMover = $ItemMover as ItemMover
@onready
var _receiver: ItemReceiver = $ItemReceiver as ItemReceiver

func _ready() -> void:
	super()
	_initializeChildren()

func _initializeChildren() -> void:
	_mover.initialize(facing, _receiver)
	_receiver.initialize(Facing.allExcept(Facing.opposite(facing)), _mover)

func initializeWithNewFacing(newFacing: Facing.CARDINAL) -> void:
	facing = newFacing
	_initializeChildren()

func getReceiver() -> ItemReceiver:
	return _receiver
