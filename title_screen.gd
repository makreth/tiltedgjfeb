extends Node2D

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainLevel.tscn")

func _on_start_game_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/jacobLevel.tscn")

func _on_credits_pressed() -> void:
	#get_tree().change_scene_to_file("res://Assets/Scenes/Credits.tscn")
	pass
