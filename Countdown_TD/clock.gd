extends Label

@onready var gc = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_text = ""
	if gc.is_day:
		new_text = str(snapped(gc.day_length - gc.timer, 0.1))
		$day.visible = true
		$night.visible = false
	else:
		new_text = str(snapped(gc.night_length - gc.timer, 0.1))
		$day.visible = false
		$night.visible = true
	
	text = new_text
