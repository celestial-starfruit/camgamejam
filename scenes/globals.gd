extends Node

var is_tower_selected := false
var tower_selected := 0
enum Towers {PEASHOOTER, FIRE, FREEZE}
enum Bases {EAST, NORTH, WEST, SOUTH}
var current_base := Bases.EAST
var player_time_left: float = 0
var tower_dict := {
	Towers.PEASHOOTER: preload("uid://csid4neeyuice"),
	Towers.FIRE: preload("uid://c62qx21jbee7w"),
	Towers.FREEZE: preload("uid://bnnner1yfnlow")
}
var enemy_count: int
enum GameStates {BUILD, DEFEND, ESCAPE}
var current_game_state: int = GameStates.BUILD
var round: int
var tower_counts := {
	Towers.PEASHOOTER: 0,
	Towers.FIRE: 0,
	Towers.FREEZE: 0
}
var tower_names := {
	"Peashooter": 0,
	"Fire": 1,
	"Freeze": 2
}
var tower_sprites := {
	Towers.PEASHOOTER: preload("uid://n5yja2xmhjr4"),
	Towers.FIRE: preload("uid://c3w8eru64r5gr"),
	Towers.FREEZE: preload("uid://bopwdcrywv7c8")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func is_out_of_towers():
	var count = 0
	for i in tower_counts:
		if tower_counts[i] != 0:
			count += 1
	return count == 0
