extends Node2D

@onready var camera = $Camera2D

@onready var transition_scene: Control = $TransitionScene

func _ready() -> void:
	camera.make_current()
	transition_scene.visible = true

	## Mute game in debug mode
	if OS.is_debug_build():
		_on_audio_button_toggled(false)

func _on_audio_button_toggled(toggled_on: bool) -> void:
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, toggled_on)
