extends CanvasLayer

const TITLE = preload("uid://da2pdkk4ki43s")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.play_music(TITLE)

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
