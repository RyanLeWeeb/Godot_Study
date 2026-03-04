extends CharacterBody2D
class_name Player



const SPEED = 100 # pixels
const PUSH_FORCE = 2


@export var health: int = 1
@export var stats : Stats
var was_attacked: bool = false



func _physics_process(_delta):
	var input_vec = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input_vec.x += 1
	if Input.is_action_pressed("move_left"):
		input_vec.x -= 1
	if Input.is_action_pressed("move_down"):
		input_vec.y += 1
	if Input.is_action_pressed("move_up"):
		input_vec.y -= 1

# - ↑ Movement Input   ↑
# - ↓ Moving correctly ↓

	velocity = input_vec.normalized() * SPEED   # CharacterBody2D `velocity` property
	move_and_slide()                            # uses the node's velocity and physics step

	for i in range(get_slide_collision_count()): # Makes character be able to push rigidbodies
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)

# - ↑ Moving correctly ↑
# - ↓ Health behaviour ↓

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("has_hit"):
		var node = area.get_parent() as Node
		health -= node.base_damage
		if health <= 0: 
			hide() # Simply hides the character

func _on_hurtbox_timer_timeout() -> void:
	was_attacked = false

# - ↑ Health behaviour ↑
