extends Control


var pathfinder: CharacterBody2D = null # found in the _ready() func
var player: CharacterBody2D = null # found in the _ready() func
var nav_agent: NavigationAgent2D = null # found in the _ready() func
@onready var debug_button: Button = %DebugButton
@onready var health_bar: ProgressBar = %HealthBar
@onready var health_label: Label = %HealthBar/HealthLabel

func _ready():
	# Wait until the very end of the current frame
	await get_tree().process_frame 
	player = get_tree().get_first_node_in_group("Players") as CharacterBody2D
	player.stats.health_changed.connect(_on_health_changed)
	
	health_bar.value = player.stats.health
	health_label.text = "Health: " + str(player.stats.health) + " / " + str(player.stats.max_health)
	
	# Ask the tree for the first node in the "pathfinders" group
	pathfinder = get_tree().get_first_node_in_group("Pathfinders") as CharacterBody2D
	
	# NOTE: Always a good idea to check if it actually found something
	if pathfinder == null:
		print("Warning: No node found in 'pathfinders' group!")
	
	# Next section: finds the nav_agent after the pathfinder was found
	
	for i in range(pathfinder.get_child_count()):
		
		if pathfinder.get_child(i).name == "Navigation Node" and pathfinder.get_child(i) is Node2D:
			var nav_node: Node2D = pathfinder.get_child(i)
			
			for j in range(nav_node.get_child_count()):
				if nav_node.get_child(j).name == "NavigationAgent2D" and nav_node.get_child(j) is NavigationAgent2D:
					nav_agent = nav_node.get_child(j)
	
	debug_button.pressed.connect( func():
		if pathfinder:
			nav_agent.debug_enabled = !nav_agent.debug_enabled
			debug_button.toggle_mode = true
		)

func _process(_delta: float) -> void:
	if not pathfinder:
		debug_button.disabled = true
	else:
		debug_button.disabled = false
	
	# TODO: make the system look for pathfinders after amount of time has elapsed

func _on_health_changed(new_health: int) -> void:
	if health_bar:
		health_bar.value = new_health
	if health_label:
		var max_hp = player.stats.max_health
		health_label.text = "Health: " + str(new_health) + " / " + str(max_hp)
