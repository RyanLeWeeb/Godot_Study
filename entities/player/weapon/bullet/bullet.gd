extends Node2D

const SPEED: int = 300

@export var stats: Stats


func _process(_delta: float) -> void:
	position += transform.x * SPEED * _delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func has_hit() -> int:
	return stats.attack
