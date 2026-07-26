extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(Globals.health)
	Globals.on_health_change.connect(_on_health_change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_health_change(value: int) -> void:
	text = str(value)
