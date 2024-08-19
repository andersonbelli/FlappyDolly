extends Button

@onready var button: Button = $"."

@export var uppercase: bool = true
@export_enum("CONFIRM", "CLOSE/CANCEL", "WARNING") var button_type: int = 0

const CONFIRM_PRESSED_TEXTURE = preload("res://scenes/resources/button_style/confirm_pressed_texture.tres")
const CONFIRM_UMPRESSED_TEXTURE = preload("res://scenes/resources/button_style/confirm_umpressed_texture.tres")

const CANCEL_PRESSED_TEXTURE = preload("res://scenes/resources/button_style/cancel_pressed_texture.tres")
const CANCEL_UMPRESSED_TEXTURE = preload("res://scenes/resources/button_style/cancel_umpressed_texture.tres")

const WARNING_PRESSED_TEXTURE = preload("res://scenes/resources/button_style/warning_pressed_texture.tres")
const WARNING_UMPRESSED_TEXTURE = preload("res://scenes/resources/button_style/warning_umpressed_texture.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if uppercase:
		text = text.to_upper()

	button.text = text
	
	var pressed_texture = CONFIRM_PRESSED_TEXTURE
	var umpressed_texture = CONFIRM_UMPRESSED_TEXTURE
	
	match button_type:
		0:
			pressed_texture = CONFIRM_PRESSED_TEXTURE
			umpressed_texture = CONFIRM_UMPRESSED_TEXTURE
		1:
			pressed_texture = CANCEL_PRESSED_TEXTURE
			umpressed_texture = CANCEL_UMPRESSED_TEXTURE
		2:
			pressed_texture = WARNING_PRESSED_TEXTURE
			umpressed_texture = WARNING_UMPRESSED_TEXTURE
	
	button.add_theme_stylebox_override("normal", umpressed_texture)
	button.add_theme_stylebox_override("hover", umpressed_texture)
	
	button.add_theme_stylebox_override("pressed", pressed_texture)

	button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
