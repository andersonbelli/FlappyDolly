extends Node2D

const PipeScene = preload("res://scenes/pipe_scene.tscn")

@onready var spawn_timer = $SpawnTimer
@onready var score_label = $ScoreLabel

var speed_increased = false

func _process(delta):
	score_label.text = str(Globals.SCORE)
	
	if (Globals.SCORE % 5 == 0 && Globals.SCORE != 0):
		if not speed_increased:
			speed_increased = true
			print(str(Globals.SCORE) + " - ", Globals.SCORE % 5)
			Globals.GAME_SPEED += 55
			spawn_timer.wait_time -= 0.2
	else:
		speed_increased = false

func _on_spawn_timer_timeout():
	var pipe = PipeScene.instantiate() as PipeClass
	
	add_child(pipe)
