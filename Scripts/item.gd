class_name Item extends Area2D

@export
var value: int:
	get:
		return value
	set(newValue):
		value = newValue
		updateLabel()

@onready
var _label: Label = $PanelContainer/Label

var _moving = false

func _ready() -> void:
	updateLabel()

func isLocked() -> bool:
	return _moving

func updateLabel() -> void:
	if not _label:
		return
	_label.text = str(value)
