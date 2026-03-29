extends Area2D
class_name Hurtbox



func _ready() -> void:
	area_entered.connect(_on_area_entered)
	collision_layer = 0
	collision_mask = 1 << 4 # detecting HIT-boxes
	# mask is set as 5

func _on_area_entered(hitbox: Area2D) -> void:
	# 1. Find the characters
	var attacker = hitbox.owner if hitbox.owner else hitbox.get_parent()
	var target = owner if owner else get_parent()
	
	# 2. Safety Check: If the attacker is a Bullet, check its specific stats variable
	if attacker is Bullet and attacker.stats == null:
		print("Error: Bullet hit target but has no stats assigned!")
		return

	# 3. Faction Check
	if attacker.get("stats"):
		if attacker.stats.faction == target.stats.faction:
			return # Don't hit teammates
			
	# 4. Apply Damage
	if attacker.has_method("has_hit") and target.has_method("take_damage"):
		target.take_damage(attacker.has_hit())
		
		# Destroy bullet on impact
		if attacker is Bullet:
			attacker.queue_free()
