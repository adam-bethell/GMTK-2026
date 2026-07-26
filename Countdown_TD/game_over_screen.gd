extends AnimatedSprite2D


func show_screen() -> void:
	visible = true


func _on_texture_button_button_up() -> void:
	get_tree().reload_current_scene()
