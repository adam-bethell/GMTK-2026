extends Node2D

var damage = 20
var fire_time = 0.4
var type = 1

@onready var projectilePF = preload("res://projectile.tscn")
@onready var projectile2PF = preload("res://projectile2.tscn")

func _ready() -> void:
	$Area2D.on_destroy.connect(_on_destroy)

func _on_destroy() -> void:
	queue_free()
	
func set_type (t:int) -> void:
	if t == 1:
		damage = 14
		fire_time = 0.3
		type = 1
		$AnimatedSprite2D.play("Fire1")
	elif t == 2:
		damage = 5
		fire_time = 0.6
		type = 2
		$AnimatedSprite2D.play("Fire2")
	else:
		damage = 5
		fire_time = 0.2
		type = 3
		$AnimatedSprite2D.play("Fire3")
	
var timer = 0
func _process(delta: float) -> void:
	if is_ghost:
		return
		
	timer = timer + delta
	if timer > fire_time:
		timer = 0
		if type == 1:
			single_fire()
		elif type == 2:
			splash_fire()
		else:
			cone_fire()

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
	$aoe.visible = true
	
func single_fire() -> void:
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
		$AnimatedSprite2D.play("Fire1")
		Globals.fire1SFX()
		closest_item.damage(damage)
		var projectile = projectilePF.instantiate()
		add_child(projectile)
		projectile.setup(global_position, closest_item.global_position)

func splash_fire() -> void:
	var overlapping_areas = $Area2D2.get_overlapping_areas()
	var furtheset_item = null
	var furthest_distance = 0
	for item in overlapping_areas:
		var dist = item.global_position.distance_to(global_position)
		if dist > furthest_distance:
			furthest_distance = dist
			furtheset_item = item
	if not furtheset_item == null:
		$AnimatedSprite2D.look_at(furtheset_item.global_position)
		$AnimatedSprite2D.rotate(-90)
		$AnimatedSprite2D.play("Fire2")
		Globals.fire2SFX()
		var projectile = projectile2PF.instantiate()
		add_child(projectile)
		projectile.setup(global_position, furtheset_item.global_position)
		
		$Area2D3.global_position = furtheset_item.global_position
		$Area2D3/AnimatedSprite2D.play("Explode")
		var splash_areas = $Area2D3.get_overlapping_areas()
		for item in splash_areas:
			item.damage(damage)

func cone_fire() -> void:
	var overlapping_areas = $Area2D2.get_overlapping_areas()
	var furtheset_item = null
	var furthest_distance = 0
	for item in overlapping_areas:
		var dist = item.global_position.distance_to(global_position)
		if dist > furthest_distance:
			furthest_distance = dist
			furtheset_item = item
	if not furtheset_item == null:
		$AnimatedSprite2D.look_at(furtheset_item.global_position)
		$AnimatedSprite2D.rotate(-90)
		$AnimatedSprite2D/AnimatedSprite2D.play("Spray")
		Globals.fire3SFX()
		var cone_areas =  $AnimatedSprite2D/Area2D3.get_overlapping_areas()
		for item in cone_areas:
			item.damage(damage)
