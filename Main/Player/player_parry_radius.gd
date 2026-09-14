extends Area2D

func _physics_process(_delta):
	if Input.is_action_just_pressed("Parry"):
		var overlapping_areas = get_overlapping_areas()
		
		for area in overlapping_areas:
			if area.is_in_group("enemy_projectiles"):
				print("Projectile Detected")
				
			
	
