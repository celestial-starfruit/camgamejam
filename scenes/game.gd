extends Node2D

@onready var path_tiles: TileMapLayer = $Tilesets/Paths
@onready var placeables: TileMapLayer = $Tilesets/Placeables
@onready var grid: Node2D = $Grid
@onready var towers_manager: Node2D = $TowersManager
@onready var enemy_spawn_timer: Timer = $Timers/EnemySpawn
@onready var paths: Node2D = $Paths
@onready var ui: CanvasLayer = $UI
@onready var player: Player = $Player
@onready var bases: Node2D = $Bases
@onready var player_time_limit: Timer = $Timers/PlayerTimeLimit

var all_enemies_deployed = false

const ENEMY_PATH = preload("uid://cohiqpndtgam")
const GRID_SQUARE = preload("uid://caugwk6shoruv")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.connect("play_pressed", play_tower_defence)
	
	player.visible = false
	player.disabled = true
	
	for cell_coords in placeables.get_used_cells():
		var grid_square := GRID_SQUARE.instantiate()
		grid.add_child(grid_square)
		grid_square.global_position = to_global(placeables.map_to_local(cell_coords))
	
	Globals.current_game_state = Globals.GameStates.BUILD
	Globals.tower_counts[Globals.Towers.PEASHOOTER] = 2
	Globals.tower_counts[Globals.Towers.FIRE] = 1
	Globals.tower_counts[Globals.Towers.FREEZE] = 2
		
	#await get_tree().create_timer(2).timeout
	#Globals.enemy_count = 5
	#enemy_wave()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	match Globals.current_game_state:
		Globals.GameStates.BUILD:
			if Globals.is_out_of_towers():
				Globals.is_tower_selected = false
				Globals.tower_selected = -1
		Globals.GameStates.DEFEND:
			if all_enemies_deployed and paths.get_child(0).get_children().is_empty():
				Globals.current_game_state = Globals.GameStates.ESCAPE
				var start_base_coords = bases.get_child(Globals.current_base)
				Globals.current_base = (Globals.current_base + 1) % 3 
				player.disabled = false
				player.global_position = start_base_coords.global_position
				player.visible = true
				player_time_limit.start()
				player.camera_2d.enabled = true
				Globals.player_time_left = player_time_limit.time_left
		Globals.GameStates.ESCAPE:
			pass
			
			
	
			
		

func _on_attack_cooldown_timeout() -> void:
	for tower: Tower in towers_manager.get_children():
		if tower.active_shooting:
			tower.attack()


func enemy_wave() -> void:
	all_enemies_deployed = false
	for i in Globals.enemy_count:
		var enemy_path = ENEMY_PATH.instantiate()
		enemy_spawn_timer.start()
		await enemy_spawn_timer.timeout
		paths.get_child(0).add_child(enemy_path)
	all_enemies_deployed = true
	
		
func play_tower_defence() -> void:
	Globals.current_game_state = Globals.GameStates.DEFEND
	Globals.enemy_count = 5
	enemy_wave()
	
	
