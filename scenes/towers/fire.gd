extends Tower
class_name Fire

var alternate = true

func attack() -> void:
	alternate = !alternate
	if alternate:
		$CPUParticles2D.emitting = true
		$CollisionShape2D.disabled = false
		await get_tree().create_timer(1.0).timeout
		$CollisionShape2D.disabled = true


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.hurt()
