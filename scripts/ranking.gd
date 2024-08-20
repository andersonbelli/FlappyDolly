extends Control

signal close_pressed
signal render_ranking

#@export var score_item_scene: PackedScene
var ScoreItem = preload("res://scenes/ui/score_item.tscn")

# Add your name
@onready var save_your_score: Control = $SaveYourScore
@onready var line_edit: LineEdit = $SaveYourScore/VBoxContainer/MarginContainer/LineEdit

# Ranking
@onready var ranking: Control = $Ranking
@onready var ranking_list_label: Label = $Ranking/VBoxContainer/rankingListLabel

var list_index = 0

func _ready() -> void:
	render_ranking.connect(_on_render_ranking)
	
	if Globals.PLAYER_NAME != null and Globals.PLAYER_NAME != "":
		save_your_score.visible = true
	else:
		load_ranking()
		
		save_your_score.visible = false
		ranking.visible = true

func _on_save_button_pressed() -> void:
	if line_edit.text.length() > 0:
		Globals.PLAYER_NAME = line_edit.text
		var player_file = FileAccess.open("player.data", FileAccess.WRITE)
		player_file.store_line(Globals.PLAYER_NAME)
		player_file.close()
	close_pressed.emit()
	close_pressed.get_object()

func _on_close_button_pressed() -> void:
	close_pressed.emit()

# Ranking
func load_ranking():
	print("load_ranking ")
	add_loading_scores_message()

	render_board()

func render_board(scores: Array = []) -> void:
	if scores.is_empty():
		scores = Globals.SCORES_RANKING
	
	if scores.is_empty():
		add_no_scores_message()
	else:
		ranking_list_label.text = ""
		if len(scores) > 1 and scores[0].score > scores[-1].score:
			scores.reverse()
		for i in range(len(scores)):
			var score = scores[i]
			add_item(score.player_name, str(int(score.score)))
		print("RANKING --> ", scores)

func _on_render_ranking(scores: Array = []) -> void:
	render_board(scores)

func add_item(player_name: String, score_value: String) -> void:
	var item = ScoreItem.instantiate()
	list_index += 1
	item.get_node("PlayerName").text = str(list_index) + str(". ") + player_name
	item.get_node("Score").text = score_value
	item.offset_top = list_index * 170
	ranking_list_label.add_child(item)

func add_no_scores_message():
	ranking_list_label.text = "No scores yet!"

func add_loading_scores_message() -> void:
	ranking_list_label.text = "Loading scores..."
