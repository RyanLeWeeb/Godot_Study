extends Control



@export var pathfinder: CharacterBody2D = null # assigned in "game" scene
var nav_agent: NavigationAgent2D = null # found in the _ready() func



func _ready():
	for i in range(pathfinder.get_child_count()):
		
		if pathfinder.get_child(i).name == "Navigation Node" and pathfinder.get_child(i) is Node2D:
			var nav_node: Node2D = pathfinder.get_child(i)
			
			for j in range(nav_node.get_child_count()):
				if nav_node.get_child(j).name == "NavigationAgent2D" and nav_node.get_child(j) is NavigationAgent2D:
					nav_agent = nav_node.get_child(j)
	
	var debug_button: Button = %DebugButton
	
	debug_button.pressed.connect( func():
		if pathfinder:
			nav_agent.debug_enabled = !nav_agent.debug_enabled
			debug_button.toggle_mode = true
		else:
			print("Pathfinder missing.")
			debug_button.disabled = true
		)
