extends Node

var GAME_SPEED: int = 650
var SCORE: int = 0

# Pipes
var REPEAT_PIPE_COUNT: int = 0
var LAST_PIPE_IS_BOTTOM: bool = false
var BIRD_POSITION: Vector2 = Vector2(232, 955)

func _ready() -> void:
	var file = FileAccess.open('res://.env', FileAccess.READ)
	var apiKey = file.get_line()
	file.close()

	SilentWolf.configure({
		"api_key": apiKey,
		"game_id": "FlappyDolly",
		"log_level": 1
	})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/main_scene.tscn"
	})
