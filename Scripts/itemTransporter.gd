class_name ItemTrasporter extends ItemMachine

@onready
var _mover: ItemMover = $ItemMover as ItemMover
@onready
var _receiver: ItemReceiver = $ItemReceiver as ItemReceiver

func _ready() -> void:
	super()
	_mover.initialize(facing, [_receiver])
	_receiver.initialize(Facing.allExcept(Facing.opposite(facing)), _mover)
