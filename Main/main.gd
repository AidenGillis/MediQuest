extends Node2D

@onready var hearts_box = $UI/HeartsBox
@onready var player = $Entities/Player

#Slime
@onready var slime_proj = "res://Main/Enemy/Slime_Projectile.tscn"
@export var slime_scene: PackedScene
var slime_spawn_pos: Vector2

func _ready():
	#Health
	hearts_box.setMaxHearts(player.maxHealth) #Takes max health of player to determine number of displayed hearts
	hearts_box.updateHearts(player.currentHealth) #Changes state of hearts after taking damage
	player.healthChanged.connect(hearts_box.updateHearts) #Connects the event of player losing health to update the hearts
	
	#Slime
	slime_spawn_pos = $Entities/Slime.global_position
	$Entities/Slime.tree_exited.connect(_on_slime_removed)
	$SlimeRespawnTimer.timeout.connect(_respawn_slime)
	
#Slime Functions
func _on_slime_removed():
	$SlimeRespawnTimer.start()
func _respawn_slime():
	var new_slime = slime_scene.instantiate()
	add_child(new_slime)
	new_slime.global_position = slime_spawn_pos
	
	new_slime.tree_exited.connect(_on_slime_removed)
