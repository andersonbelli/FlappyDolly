extends Node2D

const PipeScene = preload("res://scenes/pipe_scene.tscn")

@onready var spawn_timer = $SpawnTimer
@onready var score_label = $ScoreLabel

func _process(delta):
	score_label.text = str(Globals.SCORE)

func _on_spawn_timer_timeout():
	var pipe = PipeScene.instantiate() as PipeClass
	
	add_child(pipe)
