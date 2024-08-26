extends Control

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("transition")

func _on_animation_player_animation_finished(_anim_name):
	#queue_free()
	visible = false
