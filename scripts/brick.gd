extends StaticBody2D

@export var row: int
@export var total_stages: int = 3

var initial_frame: int = 0
var current_stage: int = 0  # Track current hit stage

signal brick_destroyed

func _ready():
	connect("brick_destroyed", GameController._on_brick_destroyed)
	initial_frame = (row / 2) * 3
	$Sprite2D.frame = initial_frame

func _on_ball_collision():
	current_stage += 1
	
	var next_frame = initial_frame + current_stage
	if next_frame >= $Sprite2D.vframes * $Sprite2D.hframes:
		next_frame = $Sprite2D.vframes * $Sprite2D.hframes - 1

	if current_stage < total_stages:
		# Update the sprite frame to the next stage
		$Sprite2D.frame = next_frame
	else:
		emit_signal("brick_destroyed")
		queue_free()
