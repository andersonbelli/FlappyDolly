extends Control

@onready var transition_scene: Control = $TransitionScene
@onready var game_scene = $GameScene

var camera: Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_parent().get_viewport().get_camera_2d()
	transition_scene.visible = true
	game_scene.process_mode = PROCESS_MODE_DISABLED

func _on_tutorial_scene_count_finished() -> void:
	game_scene.process_mode = PROCESS_MODE_INHERIT

func _on_game_over_scene_ranked_pressed() -> void:
	camera.position.x = 1860
	camera.position.y = 2900

func _on_ranking_scene_close_pressed() -> void:
	camera.position.x = 560
	camera.position.y = 2950

func _on_game_scene_game_over() -> void:
	camera.position.x = 540
	camera.position.y = 2950
