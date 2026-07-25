extends Area2D

signal on_destroy
func destroy_tower() ->void:
	on_destroy.emit()
