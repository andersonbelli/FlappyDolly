extends StaticBody2D

class_name PipeClass

var collided = false

func _ready():
	print("pipe posiiton", position)

func _physics_process(delta):
	var collide_with = move_and_collide(Vector2(1,0) * delta * Globals.GAME_SPEED * -1)
	
	if collide_with != null:
		if collide_with.get_collider().name == "Bird":
			var bird = collide_with.get_collider() as BirdClass
			
			collided = true
			bird.die()
	
	if position.x < -450:
		if collided == false:
			Globals.SCORE += 1

		queue_free()
