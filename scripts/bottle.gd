extends RigidBody2D


func _on_body_entered(body):
	if body.name == "Bird":
		var bird = body as BirdClass
		bird.hit()
		queue_free()
