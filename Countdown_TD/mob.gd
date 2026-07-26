extends CharacterBody2D

signal on_detonate
@onready var navAgent := $NavigationAgent2D
var target_is_set = false
var true_target = null
var speed = 100
var health = 100

func set_bonus(bonus:int) -> void:
	var h = 15 * bonus
	health = health + h
	
	var s = 15 * bonus
	speed = speed + s

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.on_day_night_change.connect(_on_day_night_change)
	$Area2D.on_damaged.connect(_on_damaged)

func _on_damaged(val: int) -> void:
	health = health - val
	if health <= 0:
		Globals.mob_died()
		queue_free()
	
func set_target(value: Vector2) ->void:
	true_target = value
	navAgent.target_position = value
	target_is_set = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if navAgent.is_navigation_finished():
		velocity = Vector2.ZERO
		if target_is_set:
			var temp = true_target.distance_to(global_position)
			if temp > 50:
				on_detonate.emit(global_position)
			else:
				Globals.mob_reached_goal()
			queue_free()
		return

	# 2. Get the next waypoint position along the calculated path
	var next_path_position: Vector2 = navAgent.get_next_path_position()
	look_at(next_path_position)
	rotate(-90)
	
	# 3. Calculate the direction vector toward that waypoint
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * speed
	
	# 4. Apply the velocity to move the CharacterBody2D
	velocity = new_velocity
	move_and_slide()

func _on_day_night_change(is_day: bool) -> void:
	if is_day:
		queue_free()
