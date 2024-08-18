extends Control

@export var game_scene: PackedScene
@export var save_score_scene: PackedScene

func _on_button_pressed():
	#get_tree().change_scene_to_packed(game_scene)
	get_parent().add_child(game_scene.instantiate())
	queue_free()


func _on_ranking_button_pressed() -> void:
	#get_parent().add_child(save_score_scene.instantiate())
	#get_tree().change_scene_to_packed(save_score_scene)
	pass
