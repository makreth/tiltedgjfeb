class_name ItemMachine extends Node2D

@export
var operation: Operation.TYPE
@export
var facing: Facing.CARDINAL = Facing.CARDINAL.UP

func _ready() -> void:
	self.rotation = Facing.radian(facing)
