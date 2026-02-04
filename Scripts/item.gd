class_name Item extends Area2D

static var _itemScene = preload("res://Packed/Item.tscn")

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

static func createWithScene(newValue: int) -> Item:
	var newItem = _itemScene.instantiate() as Item
	newItem.value = newValue
	return newItem

func isLocked() -> bool:
	return _moving

func updateLabel() -> void:
	if not _label:
		return
	_label.text = str(value)
