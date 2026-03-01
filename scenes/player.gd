extends CharacterBody2D
class_name Player

@export var speed = 300.0
@export var hitpoints = 3
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var disabled = true
var slows: int = 0

func _ready() -> void:
	Globals.player = self
	slows = 0

func _physics_process(delta: float) -> void:
	if !disabled:
		var direction := Input.get_vector("Left", "Right", "Up", "Down")
		if direction:
			velocity = direction * speed * (0.5 ** float(slows))
		else:
			velocity = Vector2.ZERO

		move_and_slide()

func hurt() -> void:
	if !animation_player.is_playing():
		animation_player.play("hurt")
		if hitpoints != 1:
			hitpoints -= 1
		else:
			Globals.game_over()
	
