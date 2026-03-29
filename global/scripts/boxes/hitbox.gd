extends Area2D
class_name Hitbox

func _ready() -> void:
	# Matches your Hurtbox mask of 1 << 4
	collision_layer = 1 << 4 
	collision_mask = 0 

# This helper function ensures the Hurtbox can always find the Stats
func get_attacker():
	return owner if owner else get_parent()
