class_name Player
extends CharacterBody2D

#MoveSpeed
@export var speed: float = 200

#Animations
@onready var Idle_anim = $Idle
@onready var Walk_anim = $Walking

#HealthSystem
signal healthChanged
var maxHealth: int = 6
var currentHealth = maxHealth
var hearts_list : Array[TextureRect]

#WallCollision
var HitsWall = false

#Runs on start
func _ready() -> void:
	currentHealth = maxHealth
	Idle_anim.show()
	Walk_anim.hide()
	Idle_anim.play("Idle_Front")

#MovementFunction
func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if Input.is_action_pressed("ui_down") == true:
		Idle_anim.hide()
		Walk_anim.show()
		Walk_anim.play("Walk_Front")
	if Input.is_action_just_released("ui_down"):
		Walk_anim.hide()
		Idle_anim.show()
		Idle_anim.play("Idle_Front")
		
	if Input.is_action_pressed("ui_up") == true:
		Idle_anim.hide()
		Walk_anim.show()
		Walk_anim.play("Walk_Back")
	if Input.is_action_just_released("ui_up"):
		Walk_anim.hide()
		Idle_anim.show()
		Idle_anim.play("Idle_Back")
		
	if Input.is_action_pressed("ui_right") == true:
		Idle_anim.hide()
		Walk_anim.show()
		Walk_anim.play("Walk_Right")
	if Input.is_action_just_released("ui_right"):
		Walk_anim.hide()
		Idle_anim.show()
		Idle_anim.play("Idle_Right")
		
	if Input.is_action_pressed("ui_left") == true:
		Idle_anim.hide()
		Walk_anim.show()
		Walk_anim.play("Walk_Left")
	if Input.is_action_just_released("ui_left"):
		Walk_anim.hide()
		Idle_anim.show()
		Idle_anim.play("Idle_Left")
	
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
		
	if currentHealth == 0:
		respawn()
		
	if currentHealth < 0:
		currentHealth = maxHealth
			
	healthChanged.emit(currentHealth)

#Puts player back to spawn position
func respawn():
	currentHealth = maxHealth
	global_position = $"../../../PlayerSpawn".global_position

#Checks for enemy attacks in player hitbox
func _on_player_hit_box_area_entered(area: Area2D) -> void:
	if area.collision_layer & (1 << 5):
		take_damage()
