extends Node2D

const PipesManager = preload("res://scenes/pipes_manager.tscn")

@onready var spawn_timer = $SpawnTimer
@onready var score_label = $ScoreLabel

var speed_increased = false

func _ready():
	add_child(PipesManager.instantiate())

func _process(_delta):
	score_label.text = str(Globals.SCORE)
	
	# Increase game speed every 10 pipes
	if (Globals.SCORE % 10 == 0 && Globals.SCORE != 0):
		if not speed_increased:
			speed_increased = true
			Globals.GAME_SPEED += 55
			spawn_timer.wait_time -= 0.2
	else:
		speed_increased = false
