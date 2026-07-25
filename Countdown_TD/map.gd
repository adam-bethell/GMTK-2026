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
	towerGhost.use_as_ghost()
	towerGhost.set_type(1)
	add_child(towerGhost)
	
	var clickableArea := $Area2D
	clickableArea.mouse_entered.connect(_on_mouse_enter)
	clickableArea.mouse_exited.connect(_on_mouse_exit)
	clickableArea.input_event.connect(_on_input_event)
	
	Globals.on_day_night_change.connect(_on_day_night_change)
	
	navRegion.bake_navigation_polygon()

var tower_type = 1
func new_tower_selected(type:int) -> void:
	Globals.select_tower()
	tower_type = type
	towerGhost.set_type(tower_type)
	if type == 1:
		tower_cost = 2
	elif type == 2:
		tower_cost = 5
	else:
		tower_cost = 10
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not isMousePresent:
		return
	var temp = towerGhost.global_position
	var new = get_viewport().get_mouse_position().floor() - Vector2(32, 32)
	new.x = new.x - (int(new.x) % 16)
	new.y = new.y - (int(new.y) % 16)
	towerGhost.global_position = new
	towerGhost.set_colour_filter(towerGhost.is_colliding())
	
var tower_cost = 1
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_released("mouse_click"):
		if towerGhost.getFilterState() or not is_day:
			return
		
		if Globals.spend_gold(tower_cost):
			Globals.tower_placed()
			var go:Node2D = towerPF.instantiate()
			go.set_type(tower_type)
			navRegion.add_child(go)
			var new = get_viewport().get_mouse_position().floor() - Vector2(32, 32)
			new.x = new.x - (int(new.x) % 16)
			new.y = new.y - (int(new.y) % 16)
			go.global_position = new
			navRegion.bake_navigation_polygon()

func _on_mouse_enter() -> void:
	isMousePresent = true
	if is_day:
		towerGhost.visible = true
	
func _on_mouse_exit() -> void:
	isMousePresent = false
	towerGhost.visible = false

func spawn_mob() -> void:
	var mob = mobPF.instantiate()
	add_child(mob)
	mob.global_position = mobSpawnPos
	mob.set_target(mobTargetPos)
	mob.on_detonate.connect(_on_mob_detonate)

func _on_mob_detonate(detonation_position) -> void:
	$DetonationArea.detonate(detonation_position)
	Globals.detonation()
	navRegion.bake_navigation_polygon()
	
var is_day = true
func _on_day_night_change(value: bool) -> void:
	is_day = value
	towerGhost.visible = is_day
