extends Node

var is_tower_selected := false
var tower_selected := 0
enum Towers {PEASHOOTER, FIRE, FREEZE}
var tower_dict := {
	Towers.PEASHOOTER: preload("uid://csid4neeyuice"),
	Towers.FIRE: preload("uid://c62qx21jbee7w"),
	Towers.FREEZE: preload("uid://bnnner1yfnlow")
}
var enemy_count: int

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
