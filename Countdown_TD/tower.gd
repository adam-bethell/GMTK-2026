extends Node2D

var damage = 20

@onready var projectilePF = preload("res://projectile.tscn")

func _ready() -> void:
	pass

var fire_time = 0.4
var timer = 0
func _process(delta: float) -> void:
	if is_ghost:
		return
		
	timer = timer + delta
	if timer > fire_time:
		timer = 0
		fire()

func set_colour_filter (value: bool) -> void:
	$ColourFilter.visible = not value
	
func is_colliding() -> bool:
	var overlapping_areas = $Area2D.get_overlapping_areas()
	var size = overlapping_areas.size()
	if size > 0:
		return false
	return true

func getFilterState() -> bool:
	return $ColourFilter.visible

var is_ghost = false
func use_as_ghost() -> void:
	$StaticBody2D.queue_free()
	is_ghost = true
	
func fire() -> void:
	var overlapping_areas = $Area2D2.get_overlapping_areas()
	var closest_item = null
	var closest_distance = 99999
	for item in overlapping_areas:
		var dist = item.global_position.distance_to(global_position)
		if dist < closest_distance:
			closest_distance = dist
			closest_item = item
	if not closest_item == null:
		$AnimatedSprite2D.look_at(closest_item.global_position)
		$AnimatedSprite2D.rotate(-90)
		$AnimatedSprite2D.play("Fire")
		closest_item.damage(damage)
		var projectile = projectilePF.instantiate()
		add_child(projectile)
		projectile.setup(global_position, closest_item.global_position)
		
