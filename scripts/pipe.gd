extends StaticBody2D

class_name PipeClass

func _physics_process(delta):
	if position.x < -450:
		Globals.SCORE += 1
		queue_free()
	
	var collide_with = move_and_collide(Vector2(1,0) * delta * Globals.GAME_SPEED * -1)
	
	if collide_with != null:
		if collide_with.get_collider().name == "Bird":
			if collide_with.get_collider().get("is_alive") == true:
				collide_with.get_collider().call("die")
