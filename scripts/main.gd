extends Node2D

func _ready() -> void:
	if OS.is_debug_build():
		_on_audio_button_toggled(true)

func _on_audio_button_toggled(toggled_on: bool) -> void:
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, toggled_on)
