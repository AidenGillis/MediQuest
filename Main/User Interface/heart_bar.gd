extends Panel

@onready var sprite = $AnimatedSprite2D
var current_state := ""

func update(whole: bool, half: bool):
	var new_state: String

	if whole:
		new_state = "whole"
	elif half:
		new_state = "Half1"
	else:
		new_state = "Half2"

	# Don't replay an animation if this heart is already in that state
	if new_state == current_state:
		return

	current_state = new_state
	sprite.play(new_state)
