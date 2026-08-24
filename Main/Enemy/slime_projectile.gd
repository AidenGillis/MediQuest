extends CharacterBody2D

@export var speed = 100
@onready var anim = $AnimatedSprite2D

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
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		queue_free()
