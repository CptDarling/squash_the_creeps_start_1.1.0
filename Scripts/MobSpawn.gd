extends Spatial

export (PackedScene) var mob_scene

signal spawn_mob(mob)

onready var spawnLocation = $SpawnPath/SpawnLocation


func _on_MobTimer_timeout():
	create_mob()
	
	
func create_mob():
	# Create a mob instance
	var mob = mob_scene.instance() as Mob
	
	# Choose a random location on the path.
	spawnLocation.unit_offset = randf()
	mob.translation = spawnLocation.translation
	
	emit_signal("spawn_mob", mob)
