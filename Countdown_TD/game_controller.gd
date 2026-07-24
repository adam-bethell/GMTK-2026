extends Node2D

@onready var map = $Map

var day_length = 5
var night_length = 10
var is_day = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

var timer = 0
var spawn_timer = 1
func _process(delta: float) -> void:
	if is_day:
		timer = timer + delta
		if timer > day_length:
			is_day = false
			Globals.day_night_changed(is_day)
			timer = 0
			spawn_timer = 1
	else:
		timer = timer + delta
		if timer > night_length:
			is_day = true
			Globals.day_night_changed(is_day)
			timer = 0
		spawn_timer = spawn_timer + delta
		if spawn_timer > 1:
			spawn_timer = 0
			map.spawn_mob()
		
