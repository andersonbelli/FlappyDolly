extends Control

signal start_pressed
signal ranking_pressed

@export var game_scene: PackedScene
@export var save_score_scene: PackedScene

func _ready() -> void:
	## Connecting StartButton event to MainScene
	connect("start_pressed", get_parent().get_parent().on_start_pressed)

func _on_start_button_pressed() -> void:
	start_pressed.emit()

func _on_ranking_button_pressed() -> void:
	ranking_pressed.emit()
