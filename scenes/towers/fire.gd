extends Tower

# const PROJECTILE = preload("uid://c7tdsm07l0w3v")
# @onready var proj_manager: Node2D = $ProjManager

func attack() -> void:
	get_node("CPUParticles2D").emitting = true
