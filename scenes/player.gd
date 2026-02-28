extends CharacterBody2D
class_name Player

@export var speed = 300.0
@onready var camera_2d: Camera2D = $Camera2D
var disabled = true

func _physics_process(delta: float) -> void:
	if !disabled:
		var direction := Input.get_vector("Left", "Right", "Up", "Down")
		if direction:
			velocity = direction * speed
		else:
			velocity = Vector2.ZERO

		move_and_slide()
