extends Node2D

@onready var rankingScene = $AddYourNameControl/RankingScene

var camera: Camera2D

func _ready() -> void:
	camera = get_parent().get_viewport().get_camera_2d()

func _on_start_screen_scene_ranking_pressed() -> void:
	if !Globals.get_player_nick().is_empty():
		rankingScene.render_ranking.emit(Globals.SCORES_RANKING)
	camera.position.y = 2880

func _on_ranking_scene_close_pressed() -> void:
	camera.position.y = 960
