extends StaticBody2D

class_name PipeDollyClass

var BottleScene = preload("res://scenes/elements/bottle_scene.tscn")

@export var throw_force := 2000

## Left arm
@onready var marker_left = $MarkerLeft as Marker2D
@onready var marker_arm_left = $DollyArmLeft/MarkerArmLeft as Marker2D
@onready var bottle_left = $"DollyArmLeft/Bottle" as RigidBody2D
@onready var dolly_arm_left = $"DollyArmLeft" as Sprite2D

## Right arm
@onready var marker_right = $MarkerRight as Marker2D
@onready var marker_arm_right = $DollyArmRight/MarkerArmRight as Marker2D
@onready var bottle_right = $DollyArmRight/Bottle as RigidBody2D
@onready var dolly_arm_right = $DollyArmRight as Sprite2D

## Elements
@onready var animation_player = $AnimationPlayer
@onready var dolly_sprite = $DollySprite
@onready var pipe_sprite = $Pipe

var bottle: BottleClass
var marker: Marker2D
var marker_arm: Marker2D
var arm_sprite: Sprite2D

var collided = false
var impulse_applied = false

var disapear_at
var is_bottom

# Rotation = Low 7.5 / High -65.5
func _ready():
	var piper_manager = (get_parent() as PipesManagerClass)
	
	is_bottom = piper_manager.is_bottom
	disapear_at = piper_manager.pipe_disaper_at
	
	if is_bottom:
		dolly_arm_right.queue_free()
		marker_right.queue_free()
		
		bottle = bottle_left
		marker = marker_left
		marker_arm = marker_arm_left
		arm_sprite = dolly_arm_left
	else:
		rotation_degrees = 180
		
		dolly_arm_left.queue_free()
		marker_left.queue_free()
		
		bottle = bottle_right
		marker = marker_right
		marker_arm = marker_arm_right
		arm_sprite = dolly_arm_right
	animation_player.play("throw_bottle")

func _process(_delta):
	if not impulse_applied:
		if arm_sprite.rotation_degrees < -36.2 or arm_sprite.rotation_degrees > 36.2:
			var impulse = throw_bottle_randomization(global_position.direction_to(Globals.BIRD_POSITION))
			bottle.impulse_force = impulse.y
			
			bottle.global_position = marker_arm.global_position
			bottle.apply_impulse(impulse, bottle.global_position)
			impulse_applied = true
		else:
			bottle.global_position = marker_arm.global_position
			bottle.rotation_degrees += 65

func _physics_process(delta):
	var collide_with = move_and_collide(Vector2(1,0) * delta * Globals.GAME_SPEED * -1)
	
	if collide_with != null:
		if collide_with.get_collider().name == "Bird":
			var bird = collide_with.get_collider() as BirdClass

			collided = true
			bird.die()
	
	if position.x < -disapear_at:
		if collided == false:
			Globals.SCORE += 1
		queue_free()

func throw_bottle_randomization(direction: Vector2, ) -> Vector2:
	direction -= Vector2(randi_range(0, 2), 0)
	
	var impulse := direction * throw_force
	impulse.x += randi_range(1, 1000)
	impulse.x -= randi_range(1, 1000)
	
	return impulse
