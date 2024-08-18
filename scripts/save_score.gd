extends Control

@onready var line_edit: LineEdit = $VBoxContainer/MarginContainer/LineEdit

func _on_button_pressed() -> void:
	if line_edit.text.length() >= 3:
		Globals.PLAYER_NAME = line_edit.text
		visible = false
