extends Node2D

@export var brick_scene: PackedScene
@export var rows: int = 12
@export var columns: int = 17
@export var brick_size: Vector2 = Vector2(32, 16)

var frame_ranges = [
	[0, 1, 2],
	[3, 4, 5],
	[6, 7, 8],
	[9, 10, 11],
	[12, 13, 14],
	[15, 16, 17]
	]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_build_wall()

func _build_wall():
	#Clear any existing tiles, just in case.
	for child in get_children():
		child.queue_free()
	
	for row in range(rows):
		for column in range(columns):
			# Instance a new brick
			var brick = brick_scene.instantiate()
			
			# Pass the row information to the brick
			brick.row = row
			
			# Name each brick
			brick.name = "Brick_%d_%d" % [row, column]
			
			# Position the brick
			brick.position = Vector2(column * brick_size.x + 4, row * brick_size.y + 4)
			
			add_child(brick)
