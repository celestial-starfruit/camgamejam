extends Area2D
class_name Tower

var draggable := false
var droppable := false
var placed := false
var active_shooting := false
var area_ref: Area2D
var offset: Vector2
var initial_pos: Vector2

@onready var attack_cooldown: Timer = $AttackCooldown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#initial_pos = global_position
		
func attack() -> void:
	pass # Implemented in children
	
