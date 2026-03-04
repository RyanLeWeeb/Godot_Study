extends Node2D

const SPEED : int = 300

var base_damage : int = 1



func _process(_delta: float) -> void:
	position += transform.x * SPEED * _delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func has_hit() -> int:
	return base_damage
