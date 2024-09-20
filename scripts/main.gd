extends Node2D

@export var initial_flow_scene: PackedScene
@export var game_scene: PackedScene

@onready var camera = $Camera2D
@onready var transition_scene: Control = $TransitionScene
@onready var audio_button: TextureButton = $AudioButton

var initial_flow
var game

func _ready() -> void:
	camera.make_current()
	transition_scene.visible = true

	## Mute game in debug mode
	if OS.is_debug_build():
		_on_audio_button_toggled(false)
		
	initial_flow = initial_flow_scene.instantiate() as Node2D
	initial_flow.show_behind_parent = true
	add_child(initial_flow)
	
	audio_button.move_to_front()

func on_start_pressed():
	transition_scene.visible = true
	
	game = game_scene.instantiate()
	add_child(game)
	
	audio_button.move_to_front()
	
	remove_child(initial_flow)

func on_restart_pressed():
	$MainAudio["parameters/switch_to_clip"] = "main"
	audio_button.position.y = 50
	camera.position.y = 960
	
	Globals.can_play = false
	
	transition_scene.visible = true
	
	initial_flow = initial_flow_scene.instantiate()
	add_child(initial_flow)
	
	audio_button.move_to_front()
	
	game.queue_free()

func on_game_over():
	audio_button.position.y = 2050

func _on_audio_button_toggled(toggled_on: bool) -> void:
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, toggled_on)
