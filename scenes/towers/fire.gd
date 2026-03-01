extends Tower
class_name Fire

func attack() -> void:
	$CPUParticles2D.emitting = true
	$CollisionShape2D.disabled = false
	await get_tree().create_timer(1.0).timeout
	$CollisionShape2D.disabled = true


func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body is Player:
		body.hurt()
