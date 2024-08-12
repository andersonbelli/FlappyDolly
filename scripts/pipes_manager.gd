extends Node2D

const PipeScene = preload("res://scenes/pipe_scene.tscn")

@export var first_pipe_position = 400

@onready var up_spawn = $UpSpawn
@onready var bottom_spawn = $BottomSpawn

var is_bottom = true if (randi_range(0, 1) % 2 == 0) else false

func _ready():
	spawn_pipe()

func _physics_process(delta):
	var pipes = get_tree().get_nodes_in_group("pipes")
	
	if not pipes.is_empty():
		var first_pipe = get_tree().get_nodes_in_group("pipes").front() as PipeClass
		var pipes_counter = get_tree().get_nodes_in_group("pipes").size()
		
		if (pipes_counter < 2 and first_pipe.position.x < first_pipe_position):
			spawn_pipe()

func spawn_pipe():
	var pipe_position := set_spawn_position()
	var pipe = PipeScene.instantiate() as PipeClass
	pipe.add_to_group("pipes")
	
	if pipe_position != null:
		pipe.position = pipe_position
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
