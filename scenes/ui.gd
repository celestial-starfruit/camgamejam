extends CanvasLayer
@onready var peashooter_available: Label = $TowerMenu/TowerContainer/PeashooterAvailable
@onready var fire_available: Label = $TowerMenu/TowerContainer/FireAvailable
@onready var freeze_available: Label = $TowerMenu/TowerContainer/FreezeAvailable
@onready var play_button: Button = $PlayButton
@onready var lives: HBoxContainer = $TopBar/HBoxContainer/Lives
@onready var wave: HBoxContainer = $TopBar/HBoxContainer/Wave
@onready var enemies_left: HBoxContainer = $TopBar/HBoxContainer/EnemiesLeft
@onready var time_left: HBoxContainer = $TopBar/HBoxContainer/TimeLeft
@onready var tower_menu: ColorRect = $TowerMenu
@onready var failure_screen: ColorRect = $FailureScreen
@onready var hp: HBoxContainer = $TopBar/HBoxContainer/HP

signal play_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.disabled = true
	failure_screen.visible = false

func _on_tower_toggled(toggled_on: bool, tower_id: int) -> void:
	Globals.is_tower_selected = toggled_on
	Globals.tower_selected = tower_id

func _process(delta: float) -> void:
	peashooter_available.text = str(Globals.tower_counts[Globals.Towers.PEASHOOTER])
	fire_available.text = str(Globals.tower_counts[Globals.Towers.FIRE])
	freeze_available.text = str(Globals.tower_counts[Globals.Towers.FREEZE])
	
	play_button.disabled = !(Globals.is_out_of_towers() and Globals.current_game_state == Globals.GameStates.BUILD)
	wave.get_child(0).text = "Wave: " + str(Globals.round)
	if Globals.current_game_state == Globals.GameStates.ESCAPE:
		hp.visible = true
		hp.get_child(0).text = "HP: " + str(Globals.player.hitpoints)
		lives.visible = false
		enemies_left.visible = false
		time_left.visible = true
		play_button.visible = false
		#tower_menu.visible = false
		time_left.get_child(0).text = "Time left: %.2f" % Globals.player_time_left
	else:
		hp.visible = false
		lives.visible = true
		lives.get_child(0).text = "Lives: " + str(Globals.lives)
		enemies_left.get_child(0).text = "Enemies approaching: " + str(Globals.enemy_count)
		enemies_left.visible = true
		time_left.visible = false
		play_button.visible = true
		#tower_menu.visible = true
	

func _on_play_button_pressed() -> void:
	emit_signal("play_pressed")


func _on_button_pressed() -> void:
	Globals.reset_variables()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func show_restart_menu():
	failure_screen.visible = true
	get_tree().paused = true
