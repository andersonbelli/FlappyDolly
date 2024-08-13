extends Node2D

@onready var pipes_manager = $PipesManager
@onready var score_label = $ScoreLabel
@onready var game_over_scene = $GameOverScene

# Guarantees that the speed will increase only once every 10 pipes
var speed_increased = false

func _ready():
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

# GameOver
func _on_bird_scene_bird_is_dead():
	pipes_manager.stop_spawn()
	score_label.visible = false
	
	game_over_scene.get_node("ScoreLabel").text = score_label.text
	
	game_over_scene.visible = true

func reset_score():
	### Implement High score
	
	Globals.SCORE = 0
	score_label.text = str(Globals.SCORE)
	
