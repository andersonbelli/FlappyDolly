extends Control

@onready var transition_scene: Control = $TransitionScene
@onready var game_scene = $GameScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition_scene.visible = true
	game_scene.process_mode = PROCESS_MODE_DISABLED

func _on_tutorial_scene_count_finished() -> void:
	game_scene.process_mode = PROCESS_MODE_INHERIT
