extends Node

@onready var bricks = null  # Node containing all brick instances

func _ready():
	bricks = get_tree().root.get_node("Main/BrickWall")
	if bricks == null:
		print("Error: Could not find BrickWall node!")
		return
	
	# Connect signals from all brick children
	for brick in bricks.get_children():
		brick.connect("brick_destroyed", _on_brick_destroyed())

func _on_brick_destroyed():
	Global.score += 10
	# Check if all bricks are destroyed
	if bricks.get_child_count() == 0:
		_restart_game()

func _restart_game():
	# Logic to restart the game
	get_tree().reload_current_scene()
