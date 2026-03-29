extends Resource
class_name Stats

enum Faction { PLAYER, ENEMY, DEFAULT }

signal health_depleted
signal health_changed(current_health: int, max_health: int)

@export var max_health: int = 10
@export var attack: int = 10
@export var defense: int = 0
@export var faction: Faction = Faction.DEFAULT

@export var health: int = 10:
	set(new_value):
		health = clampi(new_value, 0, max_health)
		health_changed.emit(health, max_health)
		if health <= 0:
			health_depleted.emit()

func take_damage(amount: int):
	self.health -= amount
