extends Control

signal ranked_pressed

func _on_restart_button_pressed() -> void:
	get_parent().get_tree().reload_current_scene()

func _on_ranking_button_pressed() -> void:
	ranked_pressed.emit()
