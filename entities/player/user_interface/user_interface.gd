extends Control

func _ready():
	var debug_button = %DebugButton
	debug_button.pressed.connect(func():
		# %Pathfinder.visible = not %Pathfinder.visible
		debug_button.toggle_mode = true
		)
