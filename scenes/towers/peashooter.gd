extends Tower

const PROJECTILE = preload("uid://c7tdsm07l0w3v")
@onready var proj_manager: Node2D = $ProjManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attack() -> void:
	var proj: CharacterBody2D
	var coords = [Vector2(0, 1), Vector2(0, -1), Vector2(-1, 0), Vector2(1, 0)]
	for dir in coords:
		proj = PROJECTILE.instantiate()
		proj.velocity = dir * proj.speed
		proj_manager.add_child(proj)
		
