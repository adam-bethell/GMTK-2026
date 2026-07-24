extends AnimatedSprite2D

var speed = 800
var is_ready = false
var origin = null
var target = null

func setup(start: Vector2, end: Vector2) -> void:
	global_position = start + Vector2(32, 32)
	target = end
	is_ready = true
	look_at(target)
	rotate(-90)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_ready:
		global_position = global_position.move_toward(target, speed *  delta)
		if global_position.distance_to(target) < 5:
			is_ready = false
			queue_free()
