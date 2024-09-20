extends VBoxContainer

class_name CharacterSelection

var label: Label
var alphabet := "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
var current_index := 0

func _ready():
	label = $Label
	label.text = alphabet[current_index]

func on_arrow_down_pressed():
	current_index = (current_index + 1) % alphabet.length()
	update_label()

func on_arrow_up_pressed():
	current_index = (current_index - 1 + alphabet.length()) % alphabet.length()
	update_label()

func update_label():
	label.text = alphabet[current_index]
