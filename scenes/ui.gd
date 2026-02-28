extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_tower_toggled(toggled_on: bool, tower_id: int) -> void:
	Globals.is_tower_selected = toggled_on
	Globals.tower_selected = tower_id
