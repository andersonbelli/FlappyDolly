extends Node2D

class_name GameClass

@onready var transition_scene: Control = $TransitionScene

@onready var pipes_manager = $PipesManager
@onready var score_label = $ScoreLabel
@onready var game_over_scene = $GameOverScene
@onready var bird = $BirdScene

# Guarantees that the speed will increase only once every 10 pipes
var speed_increased = false

func _ready():
	transition_scene.visible = true
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
	pipes_manager.stop_spawn()
	score_label.visible = false
	
	game_over_scene.get_node("ScoreLabel").text = score_label.text
	game_over_scene.visible = true
	
	SilentWolf.Scores.save_score("player_name", Globals.SCORE)

func reset_score():
	### Implement High score
	
	Globals.SCORE = 0
	score_label.text = str(Globals.SCORE)
	
