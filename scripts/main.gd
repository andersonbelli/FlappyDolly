extends Node2D

@onready var camera = $Camera2D

@onready var rankingScene = $AddYourNameControl/RankingScene
@onready var addYourNameLineEdit: LineEdit = $AddYourNameControl/RankingScene/SaveYourScore/VBoxContainer/MarginContainer/LineEdit as LineEdit

@onready var transition_scene: Control = $TransitionScene

func _ready() -> void:
	transition_scene.visible = true
	
	if OS.is_debug_build():
		_on_audio_button_toggled(true)

func _on_audio_button_toggled(toggled_on: bool) -> void:
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, toggled_on)

func _on_start_screen_scene_ranking_pressed() -> void:
	if Globals.PLAYER_NAME == null or Globals.PLAYER_NAME == "":
		addYourNameLineEdit.grab_focus()
		print("grab focus")
	else:
		await SilentWolf.check_scores_ready()
		rankingScene.render_ranking.emit(Globals.SCORES_RANKING)
	camera.position.y = 2880

func _on_ranking_scene_close_pressed() -> void:
	camera.position.y = 960
