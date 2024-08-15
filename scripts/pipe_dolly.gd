extends StaticBody2D

class_name PipeDollyClass

var BottleScene = preload("res://scenes/bottle.tscn")

@onready var bottle = $"DollyArmLeft/Bottle" as RigidBody2D
@onready var marker_arm_left = $DollyArmLeft/MarkerArmLeft as Marker2D
@onready var marker_left = $MarkerLeft

@onready var dolly_arm_left = $"DollyArmLeft"
@onready var animation_player = $AnimationPlayer

@onready var dolly_sprite = $DollySprite
@onready var pipe_sprite = $Pipe

var collided = false
var anim_finished = false
var force_applied = false

#var bottle: RigidBody2D

# Rotation = Low 7.5 / High -65.5
func _ready():
	if not (get_parent() as PipesManagerClass).is_bottom:
		rotation_degrees = 180
		
		dolly_arm_left.rotation_degrees = 0
		dolly_sprite.flip_h = true
		pipe_sprite.flip_h = true
		
	animation_player.play("throw_bottle")

func _physics_process(delta):
	#var collide_with = move_and_collide(Vector2(1,0) * delta * Globals.GAME_SPEED * -1)
	
	#if collide_with != null:
		#if collide_with.get_collider().name == "Bird":
			#var bird = collide_with.get_collider() as BirdClass

			#collided = true
			#bird.die()
	
	if anim_finished:
		var direction = global_position.direction_to(Globals.BIRD_POSITION)
		var impulse = direction * 650
		
		var bottleScene = BottleScene.instantiate() as RigidBody2D
		
		bottleScene.global_position = marker_left.position
		bottle.queue_free()
		add_child(bottleScene)
		
		bottleScene.apply_impulse(impulse)
		
		anim_finished = false
		force_applied = true
	else:
		if not force_applied:
			bottle.global_position = marker_arm_left.global_position
	
	if position.x < -450:
		if collided == false:
			Globals.SCORE += 1
		#queue_free()

func _on_animation_player_animation_finished(anim_name):
	anim_finished = true
