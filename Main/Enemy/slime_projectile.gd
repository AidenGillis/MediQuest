extends CharacterBody2D

@export var speed = 100
@onready var anim = $AnimatedSprite2D
@export var turn_speed = 360

var is_parried = false
var shooter: Node2D
var dir: Vector2 = Vector2.ZERO
var spawnPos : Vector2
var spawnRot: float
var damage: int

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	
	velocity = dir * speed
	rotation = dir.angle()
	
	anim.play()
	
func _physics_process(_delta):
	if is_parried and is_instance_valid(shooter):
		var target_dir = shooter.global_position - global_position
		
		var new_angle = rotate_toward(velocity.angle(), target_dir.angle(), deg_to_rad(turn_speed) * _delta)
		
		velocity = Vector2.from_angle(new_angle) * speed
		global_rotation = new_angle
	
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	print("Area groups: ", area.get_groups())
	print("Parried: ", is_parried)

	if is_parried:
		if area.is_in_group("enemy_hitbox"):
			queue_free()
	elif area.get_parent().is_in_group("player"):
		queue_free()
