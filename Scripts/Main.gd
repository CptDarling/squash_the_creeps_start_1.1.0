extends Node

export (PackedScene) var mob_scene

func _ready():
	randomize()



func _on_Mobs_spawn_mob(mob : Mob):
	var player_position = $Player.transform.origin
	$Mobs.add_child(mob)
	mob.initialise(player_position)
	
