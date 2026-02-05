extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	animated_sprite.play("default")
	
func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	#global_position = lerp(global_position, get_global_mouse_position(), 16.5 * delta)
	global_position = get_global_mouse_position()
	
