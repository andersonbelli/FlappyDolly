extends Control

signal ranked_pressed
signal is_highscore

@onready var highscore: TextureRect = $Highscore
@onready var animation_player: AnimationPlayer = $Highscore/AnimationPlayer

func _on_restart_button_pressed() -> void:
	animation_player.active = false
	highscore.visible = false
	get_parent().get_tree().reload_current_scene()

func _on_ranking_button_pressed() -> void:
	ranked_pressed.emit()

func _on_is_highscore():
	animation_player.active = true
	highscore.visible = true
