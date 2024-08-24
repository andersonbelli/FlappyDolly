extends Node2D

class_name BirdManagerClass

signal bird_is_dead

var is_alive = true

@onready var dead = $Dead
@onready var dead_animation = $Dead/AnimationPlayer
@onready var death_music_timer: Timer = $DeathMusicTimer

func _on_bird_play_dead_animation():
	var main_audio = get_parent().get_node("/root/MainScene/MainAudio") as AudioStreamPlayer
	main_audio.stop()
	main_audio["parameters/switch_to_clip"] = "death"
	
	dead.position = position
	dead.visible = true
	dead_animation.play("dead")
	
	death_music_timer.start()

func _on_animation_player_animation_finished(_anim_name):
	dead.queue_free()
	bird_is_dead.emit()

func _on_death_music_timer_timeout() -> void:
	var main_audio = get_parent().get_node("/root/MainScene/MainAudio") as AudioStreamPlayer
	main_audio.play()
