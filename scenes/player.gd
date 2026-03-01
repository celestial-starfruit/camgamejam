extends CharacterBody2D
class_name Player

@export var speed = 300.0
@export var hitpoints = 3
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = $Camera2D
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
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
			if direction.y:
				sprite_2d.flip_v = direction.y >= 0
				sprite_2d.play("up")
			elif direction.x:
				sprite_2d.play("run")
				sprite_2d.flip_v = false
				sprite_2d.flip_h = direction.x >= 0
		else:
			velocity = Vector2.ZERO
			sprite_2d.play("idle")
			sprite_2d.flip_v = false

		move_and_slide()

func hurt(damage: int = 1) -> void:
	if !animation_player.is_playing() and !Globals.game.counting_down:
		animation_player.play("hurt")
		if hitpoints > damage:
			hitpoints -= damage
		else:
			Globals.game.ui.hp.get_child(0).text = "HP: 0"
			Globals.game_over()
	
