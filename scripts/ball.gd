extends CharacterBody2D

@export var initial_speed: float = 200.0  # Starting speed of the ball
@export var blip_sound: AudioStreamPlayer  # Reference to the bounce sound

func _ready():
	# Randomize initial direction
	randomize()
	velocity = Vector2(randf_range(-1.0, 1.0), -1.0).normalized() * initial_speed

func _physics_process(delta: float) -> void:
	# Move the ball and detect collisions
	var collision = move_and_collide(velocity * delta)
	if collision:
		handle_collision(collision)

func handle_collision(collision: KinematicCollision2D) -> void:
	# Reflect the velocity based on the collision normal
	velocity = velocity.bounce(collision.get_normal()).normalized() * initial_speed

	# Play a bounce sound
	if blip_sound:
		blip_sound.play()

	# Get the collider
	var collider = collision.get_collider()
	if collider:
		# Paddle collision
		if collider.name == "Player":
			handle_paddle_collision(collider, collision.get_position())
		# Brick collision
		elif collider.name.begins_with("Brick"):
			if collider.has_method("_on_ball_collision"):
				collider._on_ball_collision()

func handle_paddle_collision(paddle: Node2D, collision_point: Vector2) -> void:
	# Adjust bounce angle based on the collision point on the paddle
	var paddle_width = paddle.get_node("CollisionShape2D").shape.extents.x * 2
	var relative_hit_position = (collision_point.x - paddle.global_position.x) / (paddle_width / 2)
	var max_deflection_angle = deg_to_rad(45.0)  # Maximum angle of deflection
	var deflection_angle = max_deflection_angle * relative_hit_position
	velocity = Vector2.UP.rotated(deflection_angle).normalized() * initial_speed
