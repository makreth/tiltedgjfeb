class_name ConveyorOutput extends ConveyorBelt

@export
var weights : PackedFloat32Array = [
	0.1, 0.25, 0.1, 0.25
]

@export
var rootNodePath = ^"/root/Root"

@export
var NumberItem = preload("res://SavedNodes/number_item.tscn")

var rootNode
var rng : RandomNumberGenerator

func _ready() -> void:
	super()
	timer.timeout.connect(_create_item)
	rootNode = get_node(rootNodePath)
	rng = RandomNumberGenerator.new()

func rotate_to_facing():
	pass

func _create_item() -> void:
	if locked:
		return
	
	var newItem = NumberItem.instantiate() as Item
	newItem.global_position = self.global_position
	newItem.value = rng.rand_weighted(weights) + 1
	rootNode.add_child(newItem)
