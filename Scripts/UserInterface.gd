extends Control


func _ready():
	update_high_score(Stats.high_score)


func update_score(value):
	$ScoreLabel.text = "Score: %s" % value


func update_high_score(value):
	$HighScoreLabel.text = "High Score: %s" % value


func _unhandled_input(event : InputEvent):
	if event.is_action_pressed("ui_accept") and $Retry.visible:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
