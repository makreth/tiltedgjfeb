class_name ConveyorBelt extends Area2D

enum Facing {INPUT, UP, RIGHT, DOWN, LEFT}

@export
var stepTimerPath := ^"/root/Root/StepTimer"

@export
var spritePath := ^"Sprite"

@export
var facing := Facing.RIGHT

var locked := false
var _should_push = false

var sprite : AnimatedSprite2D
var timer : Timer

var _angle_mapping = {
	Facing.INPUT : 0,
	Facing.UP : 0,
	Facing.RIGHT : PI / 2,
	Facing.DOWN : PI,
	Facing.LEFT : 3 * PI / 2,
}
var _shift_mapping = {
	Facing.INPUT : [0, 0],
	Facing.UP : [0, -64],
	Facing.RIGHT : [64, 0],
	Facing.DOWN : [0, 64],
	Facing.LEFT : [-64, 0],
}

func _ready() -> void:
	timer = get_node_or_null(stepTimerPath)
	if not timer:
		push_error("Timer not found.")
		return
	timer.timeout.connect(_toggle_should_push)

	sprite = get_node_or_null(spritePath)

	rotate_to_facing()

	sprite.play()

func rotate_to_facing():
	if sprite:
		sprite.rotation = _angle_mapping[facing]

func _toggle_should_push():
	_should_push = true

func _physics_process(_delta: float) -> void:
	locked = false

	var neighbor = _get_at_facing()

	var items = get_overlapping_areas().filter(func(i):
		return i is Item
	)

	if not neighbor:
		if items.size() > 0:
			locked = true
		return
	if neighbor.locked and items.size() > 0:
		locked = true
		return
	
	if items.size() == 0:
		return

	var item : Item = items[0] as Item

	if item.is_dragging:
		return

	if neighbor.facing == Facing.INPUT:
		var input_neighbor = neighbor as ConveyorInput
		if not input_neighbor.open:
			neighbor.sprite.play()
			input_neighbor.open = true

	if item.position != self.position:
		item.position = self.position

	if _should_push:
		if facing == Facing.INPUT:
			trigger_input(item)
		else:
			_push_to_neighbor(item)
		_should_push = false
	else:
		item.is_pushed = false

func _get_at_facing() -> ConveyorBelt:
	var query = PhysicsPointQueryParameters2D.new()
	query.collide_with_areas = true

	var shift = _shift_mapping[facing]
	query.position = Vector2(shift[0] + position.x, shift[1] + position.y)

	var result = get_world_2d().direct_space_state.intersect_point(query, 1)
	result = result.filter(func(d): return d.collider && d.collider is ConveyorBelt)
	if result.size() > 0:
		return result[0].collider
	return null
	
func _push_to_neighbor(item : Item):
	if item.is_pushed:
		return

	var shift = _shift_mapping[facing]
	var n_x = shift[0] + item.position.x
	var n_y = shift[1] + item.position.y

	item.position = Vector2(n_x, n_y)

	item.is_pushed = true

# Trigger input doesn't do anything in ConveyorBelts on their own.
# Overload the function.
func trigger_input(item : Item):
	print("Item received: " + str(item))
