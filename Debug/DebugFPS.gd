extends Node

const TIMER_LIMIT = 2.0

var timer = 0.0
var title = "Game v0.0"

func _process(delta):
	timer += delta
	if timer > TIMER_LIMIT:
		timer = 0.0
		OS.set_window_title(title + " | fps: " + str(Engine.get_frames_per_second()))
