extends Node2D

const BULLET = preload("res://entities/player/weapon/bullet/bullet.tscn")

@onready var muzzle: Marker2D = $Marker2D

var stats: Stats # We will store a reference to the Player's stats here

func _ready() -> void:
	# Look for the player in the parent hierarchy
	var p = get_parent()
	if p is Player:
		stats = p.stats

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	
	# Visual flip logic
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	scale.y = -1 if (rotation_degrees > 90 and rotation_degrees < 270) else 1

	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var bullet_instance = BULLET.instantiate()
	# Add to root so the bullet doesn't move/rotate when the player turns
	get_tree().root.add_child(bullet_instance) 
	
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = global_rotation # Match the gun's angle
	
	# SUCCESS: Pass the stats to the bullet
	if stats:
		bullet_instance.stats = stats
	else:
		# Debug fallback: if the gun couldn't find the player's stats
		print("Warning: Gun fired but had no stats to give the bullet!")
