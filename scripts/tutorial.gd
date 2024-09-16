extends Control

signal count_finished

@onready var press_start: Node2D = $PressStart

@onready var counter_animation_player: AnimationPlayer = $CounterAnimationPlayer
@onready var count_label: Label = $CountLabel

var counter = 3
var go_text: String = "GO!"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("flap"):
		press_start.visible = false
		count_label.visible = true
		counter_animation_player.play("counter")

func _on_counter_animation_player_animation_finished(anim_name: StringName) -> void:
	if count_label.text != "GO!":
		if counter != 1:
			counter -= 1
			count_label.text = str(counter)
		else:
			count_label.text = go_text

		counter_animation_player.play("counter")
	else:
		count_finished.emit()
		queue_free()
