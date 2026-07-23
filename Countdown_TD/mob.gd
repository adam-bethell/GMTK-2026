extends CharacterBody2D

@onready var navAgent := $NavigationAgent2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_target(value: Vector2) ->void:
	navAgent.target_position = value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if navAgent.is_navigation_finished():
		velocity = Vector2.ZERO
		return

	# 2. Get the next waypoint position along the calculated path
	var next_path_position: Vector2 = navAgent.get_next_path_position()
	
	# 3. Calculate the direction vector toward that waypoint
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * 20
	
	# 4. Apply the velocity to move the CharacterBody2D
	velocity = new_velocity
	move_and_slide()
