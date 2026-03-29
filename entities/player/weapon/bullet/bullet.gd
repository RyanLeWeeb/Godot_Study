extends Node2D
class_name Bullet

const SPEED: int = 300
var stats: Stats # Received from weapon.gd

func _process(delta: float) -> void:
	# Moves in the direction it is pointing
	position += Vector2.RIGHT.rotated(rotation) * SPEED * delta

func has_hit() -> int:
	if stats:
		return stats.attack
	return 10 # Default fallback damage
