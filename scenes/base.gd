extends AnimatedSprite2D
var base_num = 0
@onready var asp: AudioStreamPlayer = $AudioStreamPlayer
const BUILDING = preload("uid://dk048nwgtwraa")

signal player_reached
func _process(delta: float) -> void:
	pass




func _on_area_body_entered(body: Node2D) -> void:
	if body is Player and self == Globals.target_base:
		print("player reached target")
		Music.stop_music()
		asp.play()
		Music.play_music(BUILDING)
		player_reached.emit()
