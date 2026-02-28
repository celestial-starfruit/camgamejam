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
	
	Globals.current_base = bases.get_node("East")
	Globals.target_base = bases.get_node("North")
	var i = 0
	for base in get_tree().get_nodes_in_group("Bases"):
		Globals.bases_arr.append(base)
		base.connect("player_reached", on_player_reached_base)
		base.base_num = i
		i += 1
		
	
	for cell_coords in placeables.get_used_cells():
		var grid_square := GRID_SQUARE.instantiate()
		grid.add_child(grid_square)
		grid_square.global_position = to_global(placeables.map_to_local(cell_coords))
	
	Globals.current_game_state = Globals.GameStates.BUILD
	for path in get_tree().get_nodes_in_group("PreviewPaths"):
		path.show_preview()
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
			player.visible = false
			player_time_limit.stop()
			#player.camera_2d.enabled = false
			# kingshuk gooned here
			if Globals.is_out_of_towers():
				Globals.is_tower_selected = false
				Globals.tower_selected = -1
		Globals.GameStates.DEFEND:
			if all_enemies_deployed and get_tree().get_nodes_in_group("EnemyPaths").is_empty():
				Globals.current_game_state = Globals.GameStates.ESCAPE
				player.global_position = Globals.current_base.global_position
				player.disabled = false
				player.visible = true
				player_time_limit.stop()
				player_time_limit.start()
				#player.camera_2d.enabled = true
				#player.camera_2d.enabled = true
			if Globals.lives == 0:
				_on_player_time_limit_timeout()
		Globals.GameStates.ESCAPE:
			Globals.player_time_left = player_time_limit.time_left
			
		

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
		paths.get_child(Globals.current_base.base_num).get_node("EnemyPath").add_child(enemy_path)
	all_enemies_deployed = true
	
		
func play_tower_defence() -> void:
	Globals.current_game_state = Globals.GameStates.DEFEND
	Globals.enemy_count = 5
	enemy_wave()
	
	

func _on_player_time_limit_timeout() -> void:
	Globals.player_time_left = 0
	ui.show_restart_menu()
	
func on_player_reached_base() -> void:
	Globals.tower_counts[Globals.Towers.PEASHOOTER] = 2
	Globals.tower_counts[Globals.Towers.FIRE] = 1
	Globals.tower_counts[Globals.Towers.FREEZE] = 2
	Globals.current_base = Globals.bases_arr[(Globals.current_base.base_num + 1) % 4]
	Globals.target_base = Globals.bases_arr[(Globals.target_base.base_num + 1) % 4]
	Globals.current_game_state = Globals.GameStates.BUILD
	for path in get_tree().get_nodes_in_group("PreviewPaths"):
		path.show_preview()
