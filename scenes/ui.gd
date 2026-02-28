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

signal play_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.disabled = true

func _on_tower_toggled(toggled_on: bool, tower_id: int) -> void:
	Globals.is_tower_selected = toggled_on
	Globals.tower_selected = tower_id

func _process(delta: float) -> void:
	peashooter_available.text = str(Globals.tower_counts[Globals.Towers.PEASHOOTER])
	fire_available.text = str(Globals.tower_counts[Globals.Towers.FIRE])
	freeze_available.text = str(Globals.tower_counts[Globals.Towers.FREEZE])
	
	play_button.disabled = !(Globals.is_out_of_towers() and Globals.current_game_state == Globals.GameStates.BUILD)
	if Globals.current_game_state == Globals.GameStates.ESCAPE:
		lives.visible = false
		enemies_left.visible = false
		time_left.visible = true
		play_button.visible = false
		tower_menu.visible = false
		time_left.get_child(0).text = "Time left: " + str(Globals.player_time_left)
	else:
		lives.visible = true
		enemies_left.visible = true
		time_left.visible = false
		play_button.visible = true
		tower_menu.visible = true
		
	

func _on_button_pressed() -> void:
	emit_signal("play_pressed")
