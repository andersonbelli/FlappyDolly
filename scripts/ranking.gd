extends Control

signal close_pressed
signal render_ranking

var ScoreItem = preload("res://scenes/ui/score_item.tscn")

## Add your name
@onready var save_your_score: Control = $SaveYourScore
@onready var line_edit: LineEdit = $SaveYourScore/VBoxContainer/MarginContainer/LineEdit

## Ranking
@onready var ranking: Control = $Ranking
@onready var vbox_container: VBoxContainer = $Ranking/ScrollContainer/VBoxContainer
@onready var ranking_list_label: Label = $Ranking/ScrollContainer/VBoxContainer/rankingListLabel

var list_index = 0

func _ready() -> void:
	render_ranking.connect(_on_render_ranking)
	
	print("------------------> nickkkkk ", Globals.get_player_nick().is_empty())
	
	if Globals.get_player_nick().is_empty():
		ranking.visible = false
		save_your_score.visible = true
	else:
		load_ranking()
		
		save_your_score.visible = false
		ranking.visible = true

func _on_save_button_pressed() -> void:
	if line_edit.text.length() > 0:
		Globals.PLAYER_NAME = line_edit.text
	save_your_score.queue_free()
	ranking.visible = true
	clear_board()
	load_ranking()

func _on_close_button_pressed() -> void:
	close_pressed.emit()

## Ranking
func load_ranking():
	add_loading_scores_message()
	render_board()

func render_board(scores: Array = []) -> void:
	if scores.is_empty():
		scores = Globals.SCORES_RANKING
	
	if scores.is_empty():
		add_no_scores_message()
	else:
		ranking_list_label.text = ""
		
		reverse_order(scores)
		scores.sort_custom(sort_by_score)
		
		for i in range(len(scores)):
			var score = scores[i]
			add_item(score.player_name, str(int(score.score)))

func _on_render_ranking(scores: Array = []) -> void:
	clear_board()
	render_board(scores)

## Order items
func reverse_order(scores: Array) -> Array:
	if len(scores) > 1 and scores[0].score > scores[-1].score:
		scores.reverse()
	return scores

func sort_by_score(a: Dictionary, b: Dictionary) -> bool:
	if a.score > b.score:
		return true;
	else:
		if a.score < b.score:
			return false;
		else:
			return true;

## Board
func clear_board():
	if Globals.SCORES_RANKING != null:
		ranking_list_label.text = ""
	list_index = 0
	if vbox_container.get_child_count():
		for child in vbox_container.get_children():
			vbox_container.remove_child(child)

func add_item(player_name: String, score_value: String) -> void:
	var item = ScoreItem.instantiate()
	list_index += 1
	item.get_node("PlayerName").text = str(list_index) + str(". ") + player_name
	item.get_node("Score").text = score_value
	vbox_container.add_child(item)

func add_no_scores_message():
	ranking_list_label.text = "No scores yet!"

func add_loading_scores_message() -> void:
	ranking_list_label.text = "Loading scores..."
