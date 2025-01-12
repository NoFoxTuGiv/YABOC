extends Node

@onready var bricks = null  # Node containing all brick instances

func _ready():
	bricks = get_tree().root.get_node("Main/BrickWall")
	if bricks == null:
		print("Error: Could not find BrickWall node!")
		return

func _on_brick_destroyed():
	if not bricks == null:
		get_tree().reload_current_scene()
	Global.increment_score(10)

func _game_over():
	# For now, return to the main menu, eventually handle GO graciously
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
