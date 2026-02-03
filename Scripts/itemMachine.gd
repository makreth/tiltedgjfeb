class_name ItemMachine extends Node2D

@export
var facing: Facing.CARDINAL = Facing.CARDINAL.UP

var _itemClass = preload("res://Packed/Item.tscn")

@onready
var _sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	self.rotation = Facing.radian(facing)
	_sprite.play()
