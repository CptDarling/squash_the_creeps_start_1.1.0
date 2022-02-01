extends Node

func _ready():
	randomize()
	$UserInterface/Retry.hide()
	if !Stats.is_connected("update_score", self, "_on_Stats_update_score"):
# warning-ignore:return_value_discarded
		Stats.connect("update_score", self, "_on_Stats_update_score")
	if !Stats.is_connected("update_high_score", self, "_on_Stats_update_high_score"):
# warning-ignore:return_value_discarded
		Stats.connect("update_high_score", self, "_on_Stats_update_high_score")
	Stats.score = 0
	Stats.games_played += 1


func _on_Mobs_spawn_mob(mob : Mob):
	# We connect the mob to the score label to update the score upon squashing one.
# warning-ignore:return_value_discarded
	mob.connect("squashed", self, "_on_Mob_squashed")
	
	var player_position = $Player.transform.origin
	$Mobs.add_child(mob)
	mob.initialise(player_position)


func _on_Player_hit():
	$Mobs/MobTimer.stop()
	$UserInterface/Retry.show()


func _on_Mob_squashed():
	Stats.score += 1


func _on_Stats_update_score():
	$UserInterface.update_score(Stats.score)


func _on_Stats_update_high_score():
	$UserInterface.update_high_score(Stats.high_score)
