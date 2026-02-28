extends Tower

const PROJECTILE = preload("uid://c7tdsm07l0w3v")
@onready var proj_manager: Node2D = $ProjManager

func attack() -> void:
	var proj: Area2D
	var coords = [Vector2(0, 1), Vector2(0, -1), Vector2(-1, 0), Vector2(1, 0)]
	for dir in coords:
		proj = PROJECTILE.instantiate()
		proj.direction = dir
		proj_manager.add_child(proj)
		
