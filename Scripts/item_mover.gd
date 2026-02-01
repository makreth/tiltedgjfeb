class_name ConveyorBelt extends Area2D

enum Facing {UP, RIGHT, DOWN, LEFT}

@export
var stepTimerPath := ^"/root/Root/StepTimer"

@export
var spritePath := ^"Sprite2D"

@export
var facing := Facing.RIGHT

var _angle_mapping = {
	Facing.UP : 0,
	Facing.RIGHT : PI / 2,
	Facing.DOWN : PI,
	Facing.LEFT : 3 * PI / 2,
}

var _shift_mapping = {
	Facing.UP : [0, -32],
	Facing.RIGHT : [32, 0],
	Facing.DOWN : [0, 32],
	Facing.LEFT : [-32, 0],
}

func _ready() -> void:
	var timer : Timer = get_node_or_null(stepTimerPath)
	if not timer:
		push_error("Timer not found.")
		return
	timer.timeout.connect(_push_to_facing)

	var sprite : Sprite2D = get_node_or_null(spritePath)

	if sprite:
		sprite.transform = sprite.transform.rotated(_angle_mapping[facing])

func _push_to_facing():
	var shift = _shift_mapping[facing]
	var n_x = shift[0]
	var n_y = shift[1]

	var items = get_overlapping_bodies()

	if items.size() == 0:
		return

	if items.size() > 1:
		push_warning("Detected multiple Area2Ds above node. Defaulting to first node.")

	var item : Area2D = items[0]

	item.transform.x = n_x
	item.transform.y = n_y
