extends CharacterBody2D


const SPEED = 420.0
const FLAP_FORCE = 300.0

func _physics_process(delta):
	# add gravity
	if not is_on_floor():
		velocity.y += SPEED * delta

	if Input.is_action_just_pressed("flap"):
		var flap = clamp(velocity.y - FLAP_FORCE, -350, 300)
		velocity.y = flap
		
		var bird_rotation = rotation - 50 * delta
		bird_rotation = clampf(bird_rotation, -0.45, 5)
		
		rotation = bird_rotation
	else:
		var bird_rotation = clampf(1 * delta + rotation, -2, 1.2)
		
		print(bird_rotation)
		rotation = bird_rotation

	move_and_collide(velocity * delta)
