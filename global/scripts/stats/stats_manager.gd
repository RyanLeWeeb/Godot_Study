extends Resource
class_name Stats



enum Faction{
	PLAYER,
	ENEMY,
	DEFAULT
}

const BASE_LEVEL_XP: float = 100.0

signal health_depleted
signal health_changed(cur_health: int, max_health: int)

@export var base_max_health: int = 100
@export var base_attack: int = 10
@export var base_defense: int = 10
@export var experience: int = 0: set = _on_experience_set
@export var faction: Faction = Faction.DEFAULT

var level: int: 
	get(): return floor(max(1.0, sqrt(experience / BASE_LEVEL_XP) + 0.5))
var current_max_health: int = 100
var current_attack: int = 10
var current_defense: int = 10
 
var health: int = 0: set = _on_health_set



func _init() -> void:
	setup_stats.call_deferred()

func setup_stats() -> void:
	recalculate_stats()
	health = current_max_health

func _on_health_set(new_value: int) -> void:
	health = clampi(new_value, 0, current_max_health)
	health_changed.emit(health, current_max_health)
	if health <= 0:
		health_depleted.emit()

func _on_experience_set(new_value: int) -> void:
	var old_level: int = level
	experience = new_value
	
	if not old_level == level:
		recalculate_stats()

func recalculate_stats() -> void:
	pass
