extends Node2D

@onready var map = $Map

var day_length = 15
var night_length = 30
var is_day = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.globals_init()
	$TowerOptions.stakes_selected.connect(_stakes_selected)
	$TowerOptions.trebuchet_selected.connect(_trebuchet_selected)
	$TowerOptions.holywater_selected.connect(_holywater_selected)
	Globals.on_health_change.connect(_on_game_over)

func _stakes_selected() -> void:
	map.new_tower_selected(1)
func _trebuchet_selected() -> void:
	map.new_tower_selected(2)
func _holywater_selected() -> void:
	map.new_tower_selected(3)

var total_time_survived = 0
var timer = 0
var spawn_max_time:float = 0.5
var spawn_timer = spawn_max_time

func _process(delta: float) -> void:
	if is_game_over:
		return
	
	total_time_survived = total_time_survived + delta
	$total_time.text = "Suvived for " + str(snapped(float(int(total_time_survived * 1000))/1000, 0.1)) + " seconds"
	
	if is_day:
		timer = timer + delta
		if timer > day_length:
			is_day = false
			Globals.day_night_changed(is_day)
			timer = 0
			spawn_timer = 1
			increase_difficulty()
	else:
		timer = timer + delta
		if timer > night_length:
			is_day = true
			Globals.day_night_changed(is_day)
			timer = 0
		spawn_timer = spawn_timer + delta
		if spawn_timer > spawn_max_time:
			spawn_timer = 0
			map.spawn_mob(mob_bonus)
		
var mob_bonus = 0
func increase_difficulty() -> void:
	night_length = night_length + 2
	spawn_max_time = spawn_max_time - 0.04
	mob_bonus = mob_bonus + 1

var is_game_over = false
func _on_game_over(value) -> void:
	if not is_game_over and value <= 0:
		is_game_over = true
		$GameOverScreen.show_screen()
		Globals.gameOverSFX()
	
