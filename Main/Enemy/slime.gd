class_name Slime
extends CharacterBody2D

@export var speed: float = 35
@onready var anim = $Slime_Animation
@onready var projectile = load("res://Main/Enemy/Slime_Projectile.tscn")
@onready var player = get_tree().get_first_node_in_group("player")
var start_position: Vector2
var target: Player

var maxHealth: int = 3
var currentHealth = maxHealth

func _ready():
	$SlimeHitbox.add_to_group("enemy_hitbox")
	currentHealth = maxHealth
	start_position = global_position
	target = player
	anim.connect("frame_reached", _on_slime_frame_reached)
	
func update_velocity():
	if(global_position.distance_to(player.global_position)<250):
		var direction = (player.global_position - global_position)
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2(0,0);
	if(global_position.distance_to(player.global_position)<250 and global_position.distance_to(player.global_position)>10):
		anim.play("Slime_bounce")
	
	else:
		anim.stop()
	
func _physics_process(_delta: float) -> void:
	update_velocity()
	move_and_slide()
	
func shoot():
	if target == null:
		return
	
	var instance = projectile.instantiate()
	instance.shooter = self
	
	var to_player: Vector2 = target.global_position - global_position
	var dir: Vector2 = to_player.normalized()
	
	instance.dir = dir
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	instance.damage = 1
	
	get_tree().current_scene.call_deferred("add_child", instance)
	
func take_damage():
	currentHealth -= 1
	print(currentHealth)
		
	if currentHealth == 0:
		queue_free()	
	
func _on_slime_hitbox_area_entered(area: Area2D) -> void:
	if area.collision_layer & (1 << 4):
		take_damage()
	
func _on_slime_frame_reached(frame: int):
	if frame == 0:
		shoot()
