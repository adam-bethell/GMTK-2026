extends Area2D

func detonate(position: Vector2) -> void:
	global_position = position
	$AnimatedSprite2D.play("Explode")
	var overlapping_areas = get_overlapping_areas()
	for item in overlapping_areas:
		item.destroy_tower()
	 
