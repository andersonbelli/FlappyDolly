extends Control

func _on_texture_button_pressed():
	get_parent().get_tree().reload_current_scene()
