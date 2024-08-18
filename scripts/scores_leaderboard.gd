extends Node


var list_index = 0
var ld_name = "main"

func _ready():
	var scores = []
	if ld_name in SilentWolf.Scores.leaderboards:
		scores = SilentWolf.Scores.leaderboards[ld_name]
	
	if len(scores) > 0: 
		render_board(scores)
	else:
		# use a signal to notify when the high scores have been returned, and show a "loading" animation until it's the case...
		# add_loading_scores_message()
		var sw_result = await SilentWolf.Scores.get_high_scores().sw_get_scores_complete
		scores = sw_result["scores"]
		# hide_message()
		render_board(scores)

func render_board(scores: Array) -> void:
	#if scores.is_empty():
		#add_no_scores_message()
	#else:
		#if len(scores) > 1 and scores[0].score > scores[-1].score:
			#scores.reverse()
		#for i in range(len(scores)):
			#var score = scores[i]
			#add_item(score.player_name, str(int(score.score)))
	pass
