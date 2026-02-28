extends Node2D

@onready var path_tiles: TileMapLayer = $Tilesets/Paths
@onready var placeables: TileMapLayer = $Tilesets/Placeables
@onready var grid: Node2D = $Grid
@onready var towers_manager: Node2D = $TowersManager
@onready var enemy_spawn_timer: Timer = $Timers/EnemySpawn
@onready var paths: Node2D = $Paths


const ENEMY_PATH = preload("uid://cohiqpndtgam")
const GRID_SQUARE = preload("uid://caugwk6shoruv")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for cell_coords in placeables.get_used_cells():
		var grid_square := GRID_SQUARE.instantiate()
		grid.add_child(grid_square)
		grid_square.global_position = to_global(placeables.map_to_local(cell_coords))
	
	await get_tree().create_timer(2).timeout
	Globals.enemy_count = 5
	enemy_wave()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_attack_cooldown_timeout() -> void:
	for tower: Tower in towers_manager.get_children():
		if tower.active_shooting:
			tower.attack()


func enemy_wave() -> void:
	for i in Globals.enemy_count:
		var enemy_path = ENEMY_PATH.instantiate()
		enemy_spawn_timer.start()
		await enemy_spawn_timer.timeout
		paths.get_child(0).add_child(enemy_path)
		
