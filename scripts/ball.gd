extends CharacterBody2D

@export var initial_speed: float = 200.0  # Starting speed of the ball
var is_attached: bool

func _ready():
	# Attach ball to paddle at beginning.
	is_attached = true

func _physics_process(delta: float) -> void:
	if is_attached:
		position.y = %Player.position.y - 10
		position.x = %Player.position.x
		if Input.is_action_just_pressed("launch"):
			launch()
	# Move the ball and detect collisions
	var collision = move_and_collide(velocity * delta)
	if collision:
		handle_collision(collision)

func launch():
	if is_attached:
		var x_vel = randf_range(-50, 50) # random angle
		var y_vel = sqrt(initial_speed * initial_speed - x_vel * x_vel) * -1 # launch upwards
		is_attached = false
		velocity = Vector2(x_vel, y_vel).normalized() * initial_speed

func handle_collision(collision: KinematicCollision2D) -> void:
	# Get current speed
	var current_speed = velocity.length()
	
	# Reflect the velocity based on the collision normal
	velocity = velocity.bounce(collision.get_normal()).normalized() * current_speed

	# Play a bounce sound
	$Blip.play()

	# Get the collider
	var collider = collision.get_collider()
	if collider:
		# Paddle collision
		if collider.name == "Player":
			handle_paddle_collision(collider, collision.get_position())
		# Wall collision
		elif collider.name.ends_with("Wall"):
			if collider.name.begins_with("South"):
				on_miss()
			if collider.name.begins_with("North"):
				increase_speed()
		# Brick collision
		elif collider.name.begins_with("Brick"):
			if collider.has_method("_on_ball_collision"):
				collider._on_ball_collision()

func increase_speed():
	var current_speed = velocity.length()
	var new_speed = current_speed + 2
	velocity = velocity.normalized() * new_speed
	#print("New Speed: ", str(velocity.length()))

func handle_paddle_collision(paddle: Node2D, collision_point: Vector2) -> void:
	var current_speed = velocity.length()
	# Adjust bounce angle based on the collision point on the paddle
	var paddle_width = paddle.get_node("CollisionShape2D").shape.extents.x * 2
	var relative_hit_position = (collision_point.x - paddle.global_position.x) / (paddle_width / 2)
	var max_deflection_angle = deg_to_rad(45.0)  # Maximum angle of deflection
	var deflection_angle = max_deflection_angle * relative_hit_position
	velocity = Vector2.UP.rotated(deflection_angle).normalized() * current_speed

func on_miss():
	is_attached = true
	if %Player.health > 0:
		%Player.health -= 1
		%HealthBar.update_health_display()
	else:
		GameController._game_over()
