extends Area2D

signal on_damaged
func damage(val: int) -> void:
	on_damaged.emit(val)
