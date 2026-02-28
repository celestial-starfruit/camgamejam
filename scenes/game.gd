extends Node2D

@onready var paths: TileMapLayer = $Tilesets/Paths
@onready var placeables: TileMapLayer = $Tilesets/Placeables
@onready var grid: Node2D = $Grid
@onready var towers_manager: Node2D = $TowersManager

const GRID_SQUARE = preload("uid://caugwk6shoruv")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for cell_coords in placeables.get_used_cells():
		var grid_square := GRID_SQUARE.instantiate()
		grid.add_child(grid_square)
		grid_square.global_position = to_global(paths.map_to_local(cell_coords))
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_attack_cooldown_timeout() -> void:
	for tower: Tower in towers_manager.get_children():
		if tower.active_shooting:
			tower.attack()
