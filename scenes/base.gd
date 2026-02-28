extends AnimatedSprite2D
var base_num = 0

signal player_reached
func _process(delta: float) -> void:
	pass




func _on_area_body_entered(body: Node2D) -> void:
	if body is Player and self == Globals.target_base:
		print("player reached target")
		player_reached.emit()
