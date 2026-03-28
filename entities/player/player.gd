extends CharacterBody2D
class_name Player



const SPEED: int = 100 # pixels
const PUSH_FORCE: int = 2


@export var stats: Stats
var was_attacked: bool = false



func _ready():
	stats.health_depleted.connect(_on_health_depleted)

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

func take_damage(damage: int) -> void:
	var new_health = stats.health - damage
	stats._on_health_changed(new_health)

func _on_health_depleted() -> void:
	hide()

# - ↑ Health behaviour ↑
