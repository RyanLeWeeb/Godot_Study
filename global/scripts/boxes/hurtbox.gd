extends Area2D
class_name Hurtbox



func _init() -> void:
	collision_layer = 0
	collision_mask = 1 << 4 # detecting HIT-boxes
	# mask is set as 5

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: Hitbox) -> void:
	var attacker = hitbox.get_parent()
	var target = owner
	if attacker and attacker.has_method("has_hit") and target and target.has_method("take_damage") and "stats" in attacker:
		target.take_damage(attacker.stats.attack)
# CRITICAL: func won't work with bullets because of "stats" being absent
# Should fix by taking owner's stats or by setting 
