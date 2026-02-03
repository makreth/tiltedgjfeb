class_name ItemFixedExponent extends ItemMachine

@export
var exponentToRaise := 2

@onready
var _mover: ItemMover = $ItemMover as ItemMover
@onready
var _receiver: ItemReceiver = $ItemReceiver as ItemReceiver

func _ready() -> void:
	super()
	_mover.initialize(facing, [_receiver])
	_receiver.initialize(Facing.allExcept(Facing.opposite(facing)), _mover)

	_mover.setTransformFunction(func(items):
		var oldItem = items.get(0)
		var newItem = _itemClass.instantiate() as Item
		newItem.value = oldItem.value ** exponentToRaise
		get_tree().current_scene.add_child(newItem)
		return newItem
	)
	self.rotate(PI / 2)
