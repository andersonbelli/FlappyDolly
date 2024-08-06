extends StaticBody2D

class_name PipeClass

@onready var up_spawn = $UpSpawn
@onready var bottom_spawn = $BottomSpawn

func _ready():
	var up_or_down = randi_range(0, 1) % 2 == 0
	position = up_spawn.position
	
	if up_or_down:
		position = bottom_spawn.position
		position.y += randi_range(0, 250)
	else:
		position.y -= randi_range(0, -250)

func _physics_process(delta):
	if position.x < -450:
			Globals.SCORE += 1
			queue_free()
	
	move_and_collide(Vector2(1,0) * delta * Globals.GAME_SPEED * -1)
