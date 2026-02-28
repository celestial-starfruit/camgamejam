extends PathFollow2D

@export var speed: float = 0.2
@export var hitpoints: int = 5
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("EnemyPaths")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += delta * speed
	if hitpoints <= 0:
		queue_free()


func _on_enemy_area_entered(area: Area2D) -> void:
	if area is Projectile:
		hitpoints -= 1
		animation_player.play("hurt")
		area.queue_free()
	elif area.is_in_group("Bases"):
		print("enemy hits base")
		Globals.lives -= 1
		queue_free()
