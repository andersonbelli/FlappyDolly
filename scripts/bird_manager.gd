extends Node2D

class_name BirdManagerClass

signal bird_is_dead

const SPEED = 420.0
const FLAP_FORCE = 300.0

var is_alive = true

@onready var dead = $Dead
@onready var dead_animation = $Dead/AnimationPlayer

func _on_bird_play_dead_animation():
	dead.position = position
	dead.visible = true
	dead_animation.play("dead")

func _on_animation_player_animation_finished(_anim_name):
	dead.queue_free()
	bird_is_dead.emit()
