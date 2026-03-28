extends Resource
class_name Stats



enum Faction{
	PLAYER,
	ENEMY,
	DEFAULT
}

signal health_depleted
signal health_changed(health: int, max_health: int)

@export var health: int = 10
@export var max_health: int = 10
@export var attack: int = 10
@export var defense: int = 10
@export var faction: Faction = Faction.DEFAULT
 


func _on_health_changed(new_value: int) -> void:
	health = clampi(new_value, 0, max_health)
	health_changed.emit(health, max_health)
	if health <= 0:
		health_depleted.emit()
