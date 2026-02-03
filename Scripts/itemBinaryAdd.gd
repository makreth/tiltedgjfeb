class_name ItemBinaryAdd extends ItemMachine

@onready
var _mover: ItemMover = $ItemMover as ItemMover
@onready
var _receiver1: ItemReceiver = $ItemReceiver1 as ItemReceiver
@onready
var _receiver2: ItemReceiver = $ItemReceiver2 as ItemReceiver

func _ready() -> void:
	super()
	_mover.initialize(facing, [_receiver1, _receiver2])
	_receiver1.initialize(Facing.all(), _mover)
	_receiver2.initialize(Facing.all(), _mover)

	_mover.setTransformFunction(func(items):
		var item1 = items.get(0)
		var item2 = items.get(1)
		var newItem = _itemClass.instantiate() as Item
		newItem.value = item1.value + item2.value
		get_tree().current_scene.add_child(newItem)
		return newItem
	)
