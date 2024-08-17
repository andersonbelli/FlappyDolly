extends RigidBody2D

class_name BottleClass

var impulse_force = 150:
	set(value):
		impulse_force = value / 8 + clamp(Globals.SCORE, 0, 100)

func _on_body_entered(_body):
	queue_free()
