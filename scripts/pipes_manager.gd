extends Node2D

class_name PipesManagerClass

const PipeScene = preload("res://scenes/pipe_scene.tscn")
const PipeDollyScene = preload("res://scenes/pipe_dolly_scene.tscn")

@export var first_pipe_position = 400

@onready var up_spawn = $UpSpawn
@onready var bottom_spawn = $BottomSpawn

var is_bottom = true if (randi_range(0, 1) % 2 == 0) else false
var pipe_or_dolly = true if (randi_range(0, 1) % 2 == 0) else false

var can_spawn := true

func _ready():
	can_spawn = true
	#spawn_pipe()
	spawn_dolly_pipe()

func _physics_process(delta):
	if can_spawn:
		var pipes = get_tree().get_nodes_in_group("pipes")
		
		if not pipes.is_empty():
			var first_pipe = get_tree().get_nodes_in_group("pipes").front()
			var pipes_counter = get_tree().get_nodes_in_group("pipes").size()
			
			if (pipes_counter < 2 and first_pipe.position.x < first_pipe_position):
				#spawn_dolly_pipe()
				print("spawn")
				#spawn_pipe()
				
				#if Globals.SCORE > 3:
					#if pipe_or_dolly:
						#print("dolly!!!!")
						#spawn_dolly_pipe()
					#else:
						#spawn_pipe()
				#else:
					#spawn_pipe()


func stop_spawn():
	can_spawn = false

func spawn_pipe():
	var pipe_position := set_spawn_position()
	var pipe = PipeScene.instantiate() as PipeClass
	pipe.add_to_group("pipes")
	
	if pipe_position != null:
		pipe.position = pipe_position
		add_child(pipe)

func spawn_dolly_pipe():
	var pipe_position := set_spawn_position()
	var pipe = PipeDollyScene.instantiate() as PipeDollyClass
	pipe.add_to_group("pipes")
	
	if pipe_position != null:
		pipe.position = pipe_position
		pipe.position.x -= 450
		add_child(pipe)

func set_spawn_position() -> Vector2:
	var spawn_at_position = up_spawn.position
	
	if Globals.REPEAT_PIPE_COUNT > 3:
		Globals.REPEAT_PIPE_COUNT = 0
		if Globals.LAST_PIPE_IS_BOTTOM:
			is_bottom = false
		else:
			is_bottom = true
	
	if Globals.LAST_PIPE_IS_BOTTOM:
		Globals.REPEAT_PIPE_COUNT += 1
	else:
		Globals.REPEAT_PIPE_COUNT += 1
	
	if is_bottom:
		Globals.LAST_PIPE_IS_BOTTOM = true
		spawn_at_position = bottom_spawn.position
		spawn_at_position.y += randi_range(0, 250)
	else:
		Globals.LAST_PIPE_IS_BOTTOM = false
		spawn_at_position.y -= randi_range(0, -250)
		
	return spawn_at_position
