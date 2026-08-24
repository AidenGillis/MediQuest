extends Control

@onready var pause_menu = self

var paused := false


func _ready():
	hide()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		paused = !paused
		
		if paused:
			show()
			get_tree().paused = true
		else:
			get_tree().paused = false
			hide()


func _on_resume_pressed():
	get_tree().paused = false
	hide()
	paused = false
