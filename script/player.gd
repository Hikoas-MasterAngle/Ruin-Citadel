# Player.gd
extends CharacterBody2D

const SPEED = 150
const JUMP_VELOCITY = -300.0

var facing_direction: Vector2 = Vector2(1, 0) # Initially facing right

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction for left and right movement
	var direction := Input.get_axis("ui_left", "ui_right")

	# If moving, update facing direction
	if direction != 0:
		facing_direction.x = direction

	# Handle player movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
