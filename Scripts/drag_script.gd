extends StaticBody2D

@export
var value := 1

@export
var labelPath := ^"LabelBox/Label"

var is_dragging = false

func _ready():
	var l : Label = get_node_or_null(labelPath)
	if l:
		l.text = str(value)

func _process(_delta): 
	if is_dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)

func _toggleDraggingOn():
	is_dragging=true

func _toggleDraggingOff():
	is_dragging=false

func _on_StaticBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_toggleDraggingOn()
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			_toggleDraggingOff()
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()
