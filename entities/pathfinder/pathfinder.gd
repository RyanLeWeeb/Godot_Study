extends CharacterBody2D
class_name Pathfinder


@export var stats: Stats
@export var goal: Node = null 
# @onready var player = get_node("Entities/Player") 

var health = 10
var movement_speed = 50.0
var push_force = 1



# "_delta" is the time elapsed from the previous frame
func _process(delta: float) -> void:
	# - ↓ Pathfinder walks towards the player, while finding its path to the player ↓
	# Explanation at 2:20 " https://www.youtube.com/watch?v=cx49GTfLwZU "
	# " 2D Navigation & Pathfinding in Godot 4.4 | Beginner Friendly Introduction "
	
	%NavTimer.start()
	%NavigationAgent2D.target_position = goal.global_position
	var nav_direction = to_local(%NavigationAgent2D.get_next_path_position()).normalized()
	velocity = nav_direction * movement_speed # * delta
	move_and_slide()
	
	for i in range(get_slide_collision_count()): # Makes character be able to push rigidbodies
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
	
	
	if health <= 0:
		queue_free()

func _on_nav_timer_timeout() -> void:
	if %NavigationAgent2D.position != goal.global_position:
		%NavigationAgent2D.target_position = goal.global_position
		%NavTimer.start()

# - ↓ Pathfinder's debugging gets activated from player UI ↓

func _on_debug_button_toggled(_toggled_on: bool) -> void:
	%NavigationAgent2D.debug_enabled = not %NavigationAgent2D.debug_enabled
	

#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.get_parent().has_method("has_hit") == true:
		#var node = area.get_parent() as Node
		#health -= node.stats.base_attack
#
#func has_hit() -> int:
	#return stats.base_attack
