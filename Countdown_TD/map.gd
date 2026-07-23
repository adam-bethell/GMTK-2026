extends Node2D

var isMousePresent := false
@onready var mobPF := preload("res://mob.tscn")
@onready var mobSpawnPos = $NavigationRegion2D/spawn/Area2D/CollisionShape2D.global_position
@onready var mobTargetPos = $NavigationRegion2D/goal/Area2D/CollisionShape2D.global_position
@onready var towerPF := preload("res://tower.tscn")
@onready var towerGhost = null
@onready var navRegion := $NavigationRegion2D

func _ready() -> void:
	towerGhost = towerPF.instantiate()
	add_child(towerGhost)
	
	var clickableArea := $Area2D
	clickableArea.mouse_entered.connect(_on_mouse_enter)
	clickableArea.mouse_exited.connect(_on_mouse_exit)
	clickableArea.input_event.connect(_on_input_event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not isMousePresent:
		return
	var temp = towerGhost.global_position
	var new = get_viewport().get_mouse_position().floor() - Vector2(32, 32)
	if temp != new:
		towerGhost.global_position = new
		towerGhost.set_colour_filter(towerGhost.is_colliding())
	
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_released("mouse_click"):
		if towerGhost.getFilterState():
			return
		var go:Node2D = towerPF.instantiate()
		navRegion.add_child(go)
		go.global_position = get_viewport().get_mouse_position().floor() - Vector2(32, 32)
		navRegion.bake_navigation_polygon()

func _on_mouse_enter() -> void:
	isMousePresent = true
	towerGhost.visible = true
	
func _on_mouse_exit() -> void:
	isMousePresent = false
	towerGhost.visible = false

func spawn_mob() -> void:
	var mob = mobPF.instantiate()
	add_child(mob)
	mob.global_position = mobSpawnPos
	mob.set_target(mobTargetPos)
