extends Node2D

class_name PipesManagerClass

@export var PipeScene: PackedScene
@export var PipeDollyScene: PackedScene

@export var first_pipe_position = 400
@export var pipe_disaper_at = 650

@onready var up_spawn = $UpSpawn
@onready var bottom_spawn = $BottomSpawn

var is_bottom = true if (randi_range(0, 1) % 2 == 0) else false
var is_pipe_dolly = true if (randi_range(0, 1) % 2 == 0) else false

var can_spawn := true

func _ready():
	can_spawn = true
	spawn_pipe()

func _physics_process(_delta):
	if can_spawn:
		var pipes = get_tree().get_nodes_in_group("pipes")
		
		if not pipes.is_empty():
			var first_pipe = get_tree().get_nodes_in_group("pipes").front()
			var pipes_counter = get_tree().get_nodes_in_group("pipes").size()
			
			if (pipes_counter < 2 and first_pipe.position.x < first_pipe_position):
				if Globals.SCORE > 3:
					if is_pipe_dolly:
						spawn_dolly_pipe()
					else:
						spawn_pipe()
				else:
					spawn_pipe()

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
		pipe.position.x -= pipe_disaper_at
		add_child(pipe)

func add_score(score: int = 1):
	if can_spawn:
		Globals.SCORE += score

func set_spawn_position() -> Vector2:
	is_pipe_dolly = true if (randi_range(0, 1) % 2 == 0) else false
	
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
	
	var pipe_offset = offset_variation()
	
	if is_bottom:
		Globals.LAST_PIPE_IS_BOTTOM = true
		spawn_at_position = bottom_spawn.position
		spawn_at_position.y += randi_range(0, pipe_offset)
	else:
		Globals.LAST_PIPE_IS_BOTTOM = false
		spawn_at_position.y -= randi_range(0, -pipe_offset)
		
	return spawn_at_position

func offset_variation() -> int:
	var new_offset = 250
	
	if is_pipe_dolly:
		new_offset = 20
	
	return new_offset
