extends StaticBody2D

class_name PipeClass

var collided = false
var disapear_at

var pipe_manager: PipesManagerClass

func _ready():
	pipe_manager = get_parent()
	disapear_at = pipe_manager.pipe_disaper_at

func _physics_process(delta):
	var collide_with = move_and_collide(Vector2(1,0) * delta * Globals.GAME_SPEED * -1)
	
	if collide_with != null:
		if collide_with.get_collider().name == "Bird":
			var bird = collide_with.get_collider() as BirdClass
			
			collided = true
			bird.die()
	
	if position.x < -disapear_at:
		if collided == false:
			pipe_manager.add_score(1)
		queue_free()
