extends Control

@export var main_game: PackedScene

func _on_button_pressed():
	get_tree().change_scene_to_packed(main_game)
