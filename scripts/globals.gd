extends Node

signal scores_ranking_loaded

var GAME_SPEED: int = 650
var SCORE: int = 0

## Pipes
var REPEAT_PIPE_COUNT: int = 0
var LAST_PIPE_IS_BOTTOM: bool = false
var BIRD_POSITION: Vector2 = Vector2(232, 955)

## Bird
## Wait until the countdown to finish to release controls to player
var can_play := false

## Player
var player_file = ConfigFile.new()

## player file constants
const file_name = "player.data"
const file_path = "res://" + file_name
const player_nick = "nick"
const player_highscore = "highscore"

var PLAYER_NAME = "":
	set(value):
		player_file.load(file_path)
		player_file.set_value(file_name, player_nick, value)
		player_file.save(file_path)
		PLAYER_NAME = value

var PLAYER_HIGHSCORE = 0:
	set(value):
		if value != null:
			if value > PLAYER_HIGHSCORE:
				# Saving local highscore
				player_file.load("res://" + file_name)
				player_file.set_value(file_name, player_highscore, value)
				player_file.save("res://" + file_name)

				# Saving online highscore
				await save_online_score(SCORE)
				PLAYER_HIGHSCORE = value

var SCORES_RANKING = []:
	set(value):
		if value != null:
			SCORES_RANKING = value
			scores_ranking_loaded.emit()

func _ready() -> void:
	retrieve_player_data()
	
	var apiKey = ""
	
	if OS.is_debug_build():
		var env_file = FileAccess.open('res://.env', FileAccess.READ)
		apiKey = env_file.get_line()
		env_file.close()

	SilentWolf.configure({
		"api_key": apiKey,
		"game_id": "FlappyDolly",
		"log_level": 1
	})
	
	await get_tree().create_timer(0.1).timeout
	

func save_online_score(_score: int):
	if _score != 0 && not get_player_nick().is_empty():
		await SilentWolf.Scores.save_score(Globals.PLAYER_NAME, Globals.SCORE)

func load_online_score():
	await RankingScores.get_scores()
	await SilentWolf.check_sw_ready()
	await SilentWolf.check_scores_ready()
	await SilentWolf.is_node_ready()

	return SCORES_RANKING

func retrieve_player_data():
	var err = player_file.load(file_path)
	
	if err != OK:
		player_file.save(file_path)
	else:
		if player_file.has_section_key(file_name, player_nick):
			PLAYER_NAME = player_file.get_value(file_name, player_nick)

		if player_file.has_section_key(file_name, player_highscore):
			PLAYER_HIGHSCORE = player_file.get_value(file_name, player_highscore)

func get_player_nick() -> String:
	if Globals.PLAYER_NAME == null or Globals.PLAYER_NAME == "" or Globals.PLAYER_NAME.is_empty():
		return ""
	return Globals.PLAYER_NAME
