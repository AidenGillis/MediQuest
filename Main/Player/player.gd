class_name Player
extends CharacterBody2D

#MoveSpeed
@export var speed: float =200

#Animations
@onready var anim = $AnimatedSprite2D

#HealthSystem
var maxHealth: int = 6
var currentHealth = maxHealth
var hearts_list : Array[TextureRect]
"""@onready var heart_anim1 = $"../../../UI/HeartBar/Heart"
@onready var heart_anim2 = $"../../../UI/HeartBar/Heart2"
@onready var heart_anim3: AnimatedSprite2D = $"../../../UI/HeartBar/Heart3"
"""

#WallCollision
var HitsWall = false

#Runs on start
func _ready() -> void:
	currentHealth = maxHealth
	anim.play("Idle")
	"""var hearts_parent = $"../../../UI/HeartBar"
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	print(hearts_list)
	
	#Tracking when animations end
	heart_anim1.animation_finished.connect(_on_anim_finished)
	heart_anim2.animation_finished.connect(_on_anim_finished)
	heart_anim3.animation_finished.connect(_on_anim_finished)"""

#MovementFunction
func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	#Wall Collision
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
	var hit_wall_this_frame = false
		
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() is StaticBody2D:
			hit_wall_this_frame = true
			
	if hit_wall_this_frame and not HitsWall:
				$"../../../Walls/WallBump".play()
	
	HitsWall = hit_wall_this_frame
	
	#
	velocity = input_vector * speed
	move_and_slide()

#Tracking loss of Health
func take_damage():
		currentHealth -= 1
		
		if currentHealth < 0:
			currentHealth = maxHealth
			
		print(currentHealth)
		"""if currentHealth == 5:
			heart_anim3.play("Half1")
		
		elif currentHealth == 4:
			heart_anim3.play("Half2")
		
		elif currentHealth == 3:
			heart_anim2.play("Half1")
		
		elif currentHealth == 2:
			heart_anim2.play("Half2")
		
		elif currentHealth == 1:
			heart_anim1.play("Half1")
			
		elif currentHealth == 0:
			heart_anim1.play("Last_Half")
	else:
		print_debug("Health can't go below zero!")

#Respawn function resets health and hearts
func respawn():
	currentHealth = maxHealth
	heart_anim3.play("Idle")
	heart_anim2.play("Idle")
	heart_anim1.play("Idle")

#Connects with animation ending in _ready():
func _on_anim_finished() -> void:
	var anim_name := heart_anim3.animation  

	if anim_name == &"Half1":
		heart_anim3.play("IdleHalf")
	elif anim_name == &"Half2":
		heart_anim3.play("IdleEmpty")
	elif anim_name == &"Last_Half":
		heart_anim3.play("IdleEmpty")
		respawn()
"""
		

#Checks for enemy attacks in player hitbox
func _on_player_hit_box_area_entered(area: Area2D) -> void:
	if area.collision_layer & (1 << 5):
		take_damage()
