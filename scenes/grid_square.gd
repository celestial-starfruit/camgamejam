extends Area2D

var filled := false
var mouse_inside := false
@onready var preview_sprite: Sprite2D = $PreviewSprite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	preview_sprite.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.is_tower_selected and !filled and Globals.tower_counts[Globals.tower_selected] > 0:
		visible = true
		if Input.is_action_pressed("Click") and mouse_inside:
			visible = false
			filled = true
			var tower: Tower = Globals.tower_dict[Globals.tower_selected].instantiate()
			tower.global_position = global_position
			Globals.tower_counts[Globals.tower_selected] -= 1
			get_tree().get_first_node_in_group("TowersManager").add_child(tower)
			
	else:
		visible = false

			


func _on_mouse_entered() -> void:
	mouse_inside = true
	if Globals.is_tower_selected:
		preview_sprite.texture = Globals.tower_sprites[Globals.tower_selected]
		preview_sprite.visible = true


func _on_mouse_exited() -> void:
	mouse_inside = false
	preview_sprite.visible = false
