extends CanvasLayer
@onready var peashooter_available: Label = $TowerMenu/TowerContainer/PeashooterAvailable
@onready var fire_available: Label = $TowerMenu/TowerContainer/FireAvailable
@onready var freeze_available: Label = $TowerMenu/TowerContainer/FreezeAvailable


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_tower_toggled(toggled_on: bool, tower_id: int) -> void:
	Globals.is_tower_selected = toggled_on
	Globals.tower_selected = tower_id

func _process(delta: float) -> void:
	peashooter_available.text = str(Globals.tower_counts[Globals.Towers.PEASHOOTER])
	fire_available.text = str(Globals.tower_counts[Globals.Towers.FIRE])
	freeze_available.text = str(Globals.tower_counts[Globals.Towers.FREEZE])
	
