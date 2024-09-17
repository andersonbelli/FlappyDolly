extends Node2D

class_name GameClass

signal game_over

@onready var game_over_scene = $GameOverScene

@onready var pipes_manager = $PipesManager
@onready var score_label = $ScoreLabel
@onready var bird = $BirdScene

# Guarantees that the speed will increase only once every 10 pipes
var speed_increased = false

func _ready() -> void:
	connect("game_over", get_parent().get_parent().on_game_over)
	
	reset_score()

func _process(_delta):
	score_label.text = str(Globals.SCORE)

	# Increase game speed every 10 pipes
	if (Globals.SCORE % 10 == 0 && Globals.SCORE != 0):
		if not speed_increased:
			speed_increased = true
			Globals.GAME_SPEED += 55
	else:
		speed_increased = false

func _physics_process(_delta):
	Globals.BIRD_POSITION = bird.position

# GameOver
func _on_bird_scene_bird_is_dead():
	game_over.emit()

	pipes_manager.stop_spawn()
	score_label.visible = false
	game_over_scene.get_node("Scoreboard/ScoreLabel").text = str(Globals.SCORE)
	game_over_scene.visible = true

	if Globals.SCORE > Globals.PLAYER_HIGHSCORE:
		Globals.PLAYER_HIGHSCORE = Globals.SCORE
		game_over_scene.emit_signal("is_highscore")

func reset_score():
	Globals.SCORE = 0
	score_label.text = str(Globals.SCORE)
