extends CharacterBody2D

class_name BirdClass

signal play_dead_animation

const SPEED = 420.0
const FLAP_FORCE = 300.0

var is_alive = true

@onready var death_audio = $DeathAudio

func _process(delta):
	if is_alive:
		flap(delta)

	var collision_with = move_and_collide(velocity * delta)

	if collision_with != null:
		print(collision_with.get_position())
		die()

func _physics_process(delta):
	# add gravity
	if not is_on_floor():
		velocity.y += SPEED * delta

func flap(delta: float):
	if Input.is_action_just_pressed("flap"):
		var add_flap = clamp(velocity.y - FLAP_FORCE, -350, 300)
		velocity.y = add_flap

		var bird_rotation = rotation - 50 * delta
		bird_rotation = clampf(bird_rotation, -0.45, 5)

		rotation = bird_rotation
	else:
		var bird_rotation = clampf(delta + rotation, -2, 1.2)
		rotation = bird_rotation

func die():
	if is_alive:
		death_audio.play()
		is_alive = false

func _on_death_audio_finished():
	play_dead_animation.emit()
	queue_free()
