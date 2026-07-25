extends Control


func _ready() -> void:
	$Stakes/ColorRect.gui_input.connect(_on_stakes_gui)
	$Trebuchet/ColorRect.gui_input.connect(_on_trebuchet_gui)
	$HolyWater/ColorRect.gui_input.connect(_on_holywater_gui)
	
signal stakes_selected
func _on_stakes_gui(event: InputEvent) -> void:
	if event.is_action_released("mouse_click"):
		stakes_selected.emit()
	
signal trebuchet_selected
func _on_trebuchet_gui(event: InputEvent) -> void:
	if event.is_action_released("mouse_click"):
		trebuchet_selected.emit()
	
signal holywater_selected
func _on_holywater_gui(event: InputEvent) -> void:
	if event.is_action_released("mouse_click"):
		holywater_selected.emit()
