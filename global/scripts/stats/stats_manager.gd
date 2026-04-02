extends Resource
## An entity or character's statistics. 
## It contains the "health", "max_health", "attack", and "faction" values.
class_name Stats

## The enumeration for the various factions that are present in the game.
enum Faction { PLAYER, ENEMY, DEFAULT }

## The signal emitted whenever the health value is modified.
signal health_changed
## The signal emitted when the health value reaches or is under zero (0).
signal health_depleted

## The current health value the entity or character has.
@export var health: int = 10: 
	set(new_value):
		health = clampi(new_value, 0, max_health)
		if health <= 0:
			health_depleted.emit()
## The maximum amount of health an entity or character with stats can have.
@export var max_health: int = 100 
## The damage it deals to other entities or characters if the attack is successful.
@export var attack: int = 10 
## The faction an entity or character is a part of.
@export var faction: Faction = Faction.DEFAULT 


## The function that is called whenever any entity or character has received any amount of damage.
func take_damage(damage: int):
	self.health -= damage
	health_changed.emit(health)
