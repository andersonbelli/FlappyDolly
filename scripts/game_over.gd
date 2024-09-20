extends Control

signal restart_pressed
signal ranked_pressed
signal is_highscore

@onready var highscore: TextureRect = $Highscore
@onready var animation_player: AnimationPlayer = $Highscore/AnimationPlayer

func _ready() -> void:
	## Connecting RestartButton event to MainScene
	connect("restart_pressed", get_parent().get_parent().get_parent().on_restart_pressed)

func _on_restart_button_pressed() -> void:
	animation_player.active = false
	highscore.visible = false

	restart_pressed.emit()

func _on_ranking_button_pressed() -> void:
	ranked_pressed.emit()

func _on_is_highscore():
	animation_player.active = true
	highscore.visible = true
