extends Area2D
class_name Tower

var draggable := false
var droppable := false
var placed := false
var area_ref: Area2D
var offset: Vector2
var initial_pos: Vector2

@onready var attack_cooldown: Timer = $AttackCooldown



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial_pos = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Drag and drop logic
	if draggable and !placed:
		print("hi")
		if Input.is_action_just_pressed("Click"):
			offset = get_global_mouse_position() - global_position
			Globals.dragging = true
		if Input.is_action_pressed("Click"):
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("Click"):
			Globals.dragging = false
			var tween = get_tree().create_tween()
			if droppable:
				tween.tween_property(self, "position", area_ref.position, 0.2).set_ease(Tween.EASE_OUT)
				await tween.finished
				placed = true
				area_ref.filled = true
			else:
				tween.tween_property(self, "global_position", initial_pos, 0.2).set_ease(Tween.EASE_OUT)
				
	


func _on_mouse_entered() -> void:
	if !Globals.dragging and !placed:
		draggable = true
		scale = Vector2(1.05, 1.05)


func _on_mouse_exited() -> void:
	if !Globals.dragging:
		draggable = false
		scale = Vector2(1, 1)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Droppable") and !area.filled:
		droppable = true
		area.modulate = Color.AQUAMARINE
		area_ref = area


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Droppable") and !area.filled:
		droppable = false
		area.modulate = Color.WHITE
		
func attack() -> void:
	pass
	
	
#func _on_attack_cooldown_timeout() -> void:
	#attack()
