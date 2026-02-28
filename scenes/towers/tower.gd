extends Area2D
class_name Tower

var draggable := false
var droppable := false
var placed := false
var active_shooting := false
var area_ref: Area2D
var offset: Vector2
var initial_pos: Vector2

func _process(delta: float) -> void:
	active_shooting = Globals.current_game_state == Globals.GameStates["DEFEND"]

func attack() -> void:
	pass # Implemented in children
	
