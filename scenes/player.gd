extends CharacterBody2D
class_name Player

@export var speed = 300.0
@export var hitpoints = 3
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var disabled = true

func _physics_process(delta: float) -> void:
	if !disabled:
		var direction := Input.get_vector("Left", "Right", "Up", "Down")
		if direction:
			velocity = direction * speed
		else:
			velocity = Vector2.ZERO

		move_and_slide()

func hurt() -> void:
	print(hitpoints)
	if hitpoints != 1:
		hitpoints -= 1
	else:
		Globals.game_over()
	animation_player.play("hurt")
	
