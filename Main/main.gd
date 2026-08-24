extends Node2D

@onready var hearts_box = $CanvasLayer/HeartsBox
@onready var player = $TileMapBackground/Entities/Player
@onready var slime_proj = "res://Main/Enemy/Slime_Projectile.tscn"

func _ready():
	hearts_box.setMaxHearts(player.maxHealth) #Takes max health of player to determine number of displayed hearts
	hearts_box.updateHearts(player.currentHealth) #Changes state of hearts after taking damage
	player.healthChanged.connect(hearts_box.updateHearts) #Connects the event of player losing health to update the hearts
