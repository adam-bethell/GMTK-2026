extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(Globals.gold)
	Globals.on_gold_change.connect(_on_gold_change)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_gold_change(value: float) -> void:
	text = str(value)
