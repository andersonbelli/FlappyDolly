extends Node

var GAME_SPEED: int = 650
var SCORE: int = 0

# Pipes
var REPEAT_PIPE_COUNT: int = 0
var LAST_PIPE_IS_BOTTOM: bool = false
var BIRD_POSITION: Vector2 = Vector2(232, 955)

var PLAYER_NAME = ""

func _ready() -> void:
	player_file()
	
	var env_file = FileAccess.open('res://.env', FileAccess.READ)
	var apiKey = env_file.get_line()
	env_file.close()

	SilentWolf.configure({
		"api_key": apiKey,
		"game_id": "FlappyDolly",
		"log_level": 1
	})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/main_scene.tscn"
	})

func player_file(player_name: String = ""):
	var player_file = FileAccess.open('res://player.data', FileAccess.WRITE_READ)
	if player_file != null:
		PLAYER_NAME = player_file.get_line()
	else:
		PLAYER_NAME = player_name
		player_file.store_var(player_name)
	player_file.close()
