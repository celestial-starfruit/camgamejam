extends Tower
class_name Freeze

func attack() -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("freeze!")
		body.slows += 1


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.slows -= 1
