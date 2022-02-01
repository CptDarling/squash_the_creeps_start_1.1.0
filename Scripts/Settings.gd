extends Node

var music_enabled = true setget set_music_enabled

signal music_enabled_changed

func set_music_enabled(value):
	music_enabled = value
	emit_signal("music_enabled_changed")
