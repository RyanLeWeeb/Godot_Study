extends CharacterBody2D
class_name Pathfinder


@export var stats: Stats
@export var goal: Node = null 
# @onready var player = get_node("Entities/Player") 

var movement_speed: float = 50.0 # pixels
var push_force: int = 1
var is_stopping: bool = false
var movement_restart_dis: float = 50.0 # pixels

func _ready() -> void:
	stats = stats.duplicate()
	stats.health_depleted.connect(_on_health_depleted)
	
	if goal:
		%NavigationAgent2D.target_position = goal.global_position

# "_delta" is the time elapsed from the previous frame
func _physics_process(_delta: float) -> void:
	var dist = global_position.distance_to(goal.global_position)
	
	if dist < %NavigationAgent2D.target_desired_distance:
		is_stopping = true
	elif dist > movement_restart_dis:
		is_stopping = false
		
	if is_stopping:
		velocity = velocity.move_toward(Vector2.ZERO, 10.0) # Smooth stop
	else:
		if not goal or %NavigationAgent2D.is_navigation_finished():
			return
			
		var next_path_pos = %NavigationAgent2D.get_next_path_position()
		
		# If the next position is exactly where we are, direction will be (0,0)
		if global_position.distance_to(next_path_pos) > 1.0:
			var direction = global_position.direction_to(next_path_pos)
			velocity = direction * movement_speed
		else:
			velocity = Vector2.ZERO
			
		move_and_slide()
		
		# Push Logic
		for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is RigidBody2D:
				c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func _on_nav_timer_timeout() -> void:
	# Check if the goal exists before accessing it
	if goal:
		%NavigationAgent2D.target_position = goal.global_position

# - ↓ Pathfinder's debugging gets activated from player UI ↓

func _on_debug_button_toggled(_toggled_on: bool) -> void:
	%NavigationAgent2D.debug_enabled = not %NavigationAgent2D.debug_enabled

func take_damage(damage: int) -> void:
	stats.take_damage(damage) # Let the resource handle the math

func _on_health_depleted() -> void:
	print("Pathfinder died!")
	queue_free() # Actually removes the unit from the game

func has_hit() -> int:
	return stats.attack
