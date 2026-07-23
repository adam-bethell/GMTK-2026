extends Node2D

@onready var map = $Map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var timer = 0
func _process(delta: float) -> void:
	timer = timer + delta
	if timer > 1:
		timer = 0
		map.spawn_mob()
		
