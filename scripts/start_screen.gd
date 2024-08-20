extends Control

signal ranking_pressed

@export var game_scene: PackedScene
@export var save_score_scene: PackedScene

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)
	queue_free()

func _on_ranking_button_pressed() -> void:
	ranking_pressed.emit()
