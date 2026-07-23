extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_colour_filter (value: bool) -> void:
	$ColourFilter.visible = not value
	
func is_colliding() -> bool:
	var overlapping_areas = $Area2D.get_overlapping_areas()
	var size = overlapping_areas.size()
	if size > 0:
		return false
	return true

func getFilterState() -> bool:
	return $ColourFilter.visible
