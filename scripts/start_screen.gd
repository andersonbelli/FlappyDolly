extends Control

@export var game_scene: PackedScene

func _on_button_pressed():
	#get_tree().change_scene_to_packed(game_scene)
	get_parent().add_child(game_scene.instantiate())
	queue_free()
