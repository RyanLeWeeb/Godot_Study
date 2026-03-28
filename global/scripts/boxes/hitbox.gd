extends Area2D
class_name Hitbox



#var attacker_stats: Stats
#var hitbox_lifetime: float
#var shape: Shape2D
# TODO: add hitbox logging



func _init() -> void:
	collision_layer = 1 << 4 # is an HIT-box
	collision_mask = 0
	# layer is set as 5
