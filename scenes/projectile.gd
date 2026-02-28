extends Area2D


@export var speed = 300.0
var direction: Vector2

func _process(delta: float) -> void:
	global_position += speed * delta * direction
