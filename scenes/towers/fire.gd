extends Tower
class_name Fire

func attack() -> void:
	$CPUParticles2D.emitting = true
	$CollisionShape2D2.disabled = false
	await get_tree().create_timer(1.0).timeout
	$CollisionShape2D2.disabled = true
