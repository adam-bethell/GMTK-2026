extends Label

@onready var gc = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_text = ""
	if gc.is_day:
		new_text = "Day: " + str(gc.day_length - gc.timer)
	else:
		new_text = "Night: " + str(gc.night_length - gc.timer)
	
	text = new_text
