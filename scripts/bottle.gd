extends RigidBody2D

class_name BottleClass

var impulse_force = 150

func _on_body_entered(body):
	queue_free()
