extends Control

signal close_pressed

@onready var line_edit: LineEdit = $VBoxContainer/MarginContainer/LineEdit

func _on_save_button_pressed() -> void:
	if line_edit.text.length() > 0:
		Globals.PLAYER_NAME = line_edit.text
	close_pressed.emit()

func _on_close_button_pressed() -> void:
	close_pressed.emit()
