extends HBoxContainer

@onready var HeartGUIClass = preload("res://Main/User Interface/HeartBar.tscn")

func setMaxHearts(max: int):
	for i in range(max / 2):
		var heart = HeartGUIClass.instantiate()
		add_child(heart)

func updateHearts(currentHealth: int): 
	var hearts = get_children()
	
	for i in range(hearts.size()):
		var heart_health = currentHealth - (i * 2)
		
		if heart_health >= 2:
			hearts[i].update(true, false)
		elif heart_health == 1:
			hearts[i].update(false, true)
		else:
			hearts[i].update(false, false)
		
