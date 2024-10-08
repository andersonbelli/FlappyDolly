extends CharacterBody2D

class_name BirdClass

signal play_dead_animation

const SPEED = 420.0
const FLAP_FORCE = 450.0

var is_alive = true

@onready var flap_animation_player: AnimationPlayer = $FlapAnimationPlayer
@onready var death_audio = $"../DeathAudio"

@onready var slap_audio_1 = $"../Slap1"
@onready var slap_audio_2 = $"../Slap2"
@onready var slap_audio_3 = $"../Slap3"
@onready var slap_audio_4 = $"../Slap4"

var slaps = []

func _ready():
	slaps = [slap_audio_1, slap_audio_2, slap_audio_3, slap_audio_4]

func _process(delta):
	if !Globals.can_play:
		flap_animation_player.play("flap")
	
	if is_alive and Globals.can_play:
		flap(delta)
		
		var collision = move_and_collide(velocity * delta)
		if collision != null:
			if collision.get_collider().name == "WorldBoundary" or collision.get_collider().name == "PipeScene":
				die()
			elif collision.get_collider().name == "Bottle":
				var bottle = collision.get_collider() as BottleClass
				hit(bottle.impulse_force)

func _physics_process(delta):
	if Globals.can_play:
		# add gravity
		if not is_on_floor():
			velocity.y += SPEED * delta

func flap(delta: float):
	if Globals.can_play:
		if Input.is_action_just_pressed("flap"):
			flap_animation_player.play("RESET")
			flap_animation_player.play("flap")
			
			var add_flap = clamp(velocity.y - FLAP_FORCE, -350, 300)
			velocity.y = add_flap

			var bird_rotation = rotation - 50 * delta
			bird_rotation = clampf(bird_rotation, -0.45, 5)

			rotation = bird_rotation
			
			slap_on_flap()
		else:
			var bird_rotation = clampf(delta + rotation, -2, 1.2)
			velocity.y += 5
			rotation = bird_rotation

func slap_on_flap():
	var rand_slap = randi_range(0, 3)
	(slaps[rand_slap] as AudioStreamPlayer).play()

func die():
	if is_alive:
		death_audio.play()
		is_alive = false
		play_dead_animation.emit()
		
		queue_free()

func hit(impulse_force: int):
	position += Vector2(0, impulse_force)


func _on_flap_animation_player_animation_finished(anim_name: StringName) -> void:
	flap_animation_player.play("RESET")
