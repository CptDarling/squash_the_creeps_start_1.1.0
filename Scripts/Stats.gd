extends Node

var score = 0 setget set_score
var high_score = 0 setget set_high_score
var games_played = 0 setget set_games_played

var auto_load = true 

signal update_score
signal update_high_score

func set_score(value):
	score = value
	emit_signal("update_score")
	if score > high_score:
		self.high_score = score


func set_high_score(value):
	high_score = value
	emit_signal("update_high_score")
	SaveGame.save_game()


func set_games_played(value):
	games_played = value
	SaveGame.save_game()


func save():
	var save_dict = {
		"filename": get_filename(),
		"auto_load": auto_load,
		"parent": get_parent().get_path(),
		"high_score": high_score,
		"games_played": games_played,
		}
	return save_dict
