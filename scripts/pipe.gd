extends StaticBody2D

class_name PipeClass

@onready var up_spawn = $UpSpawn
@onready var bottom_spawn = $BottomSpawn

var is_bottom = true if (randi_range(0, 1) % 2 == 0) else false

func _ready():
	_set_pipe_position()

func _physics_process(delta):
	if position.x < -450:
			Globals.SCORE += 1
			queue_free()
	
	move_and_collide(Vector2(1,0) * delta * Globals.GAME_SPEED * -1)

func _set_pipe_position():
	position = up_spawn.position
	
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
		position = bottom_spawn.position
		position.y += randi_range(0, 250)
	else:
		Globals.LAST_PIPE_IS_BOTTOM = false
		position.y -= randi_range(0, -250)
