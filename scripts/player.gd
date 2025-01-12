extends CharacterBody2D

const SPEED = 300.0
var initial_y: float
var health: int

func _ready():
	initial_y = position.y
	health = 6

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_l", "move_r")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# prevent vertical movement, because for some reason the ball tries to knock it down.
	velocity.y = 0
	
	move_and_slide()
	
	position.x = clamp(position.x, 0,
	 get_viewport_rect().size.x - $CollisionShape2D.shape.extents.x)
	position.y = initial_y
