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
		Globals.game.counting_down = true
		Globals.game.player_time_limit.stop()
		Music.stop_music()
		asp.play()
		Globals.player.visible = false
		await asp.finished
		Music.play_music(BUILDING)
		Globals.game.counting_down = false
		player_reached.emit()
