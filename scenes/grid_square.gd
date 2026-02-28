extends Area2D

var filled := false
var mouse_inside := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.is_tower_selected and !filled:
		visible = true
		if Input.is_action_pressed("Click") and mouse_inside:
			visible = false
			filled = true
			var tower: Tower = Globals.tower_dict[Globals.tower_selected].instantiate()
			tower.global_position = global_position
			tower.active_shooting = true
			get_tree().get_first_node_in_group("TowersManager").add_child(tower)
	else:
		visible = false
			


func _on_mouse_entered() -> void:
	mouse_inside = true


func _on_mouse_exited() -> void:
	mouse_inside = false
