# Orb.gd
extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")

const PICKUP_RADIUS = 200.0 # Maximum distance for pick-up
var is_being_picked_up = false
var offset_from_player = Vector2(40, 3)  # Offset to maintain in front of the player

func _input(event: InputEvent) -> void:
	# Detect mouse click for pick-up
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Check distance between the ball and player
		if global_position.distance_to(player.global_position) <= PICKUP_RADIUS:
			is_being_picked_up = true

func _physics_process(_delta) -> void:
	if player:
		if is_being_picked_up:
			# Follow the player and stay in front based on facing direction
			var facing_direction = player.facing_direction
			# Set the offset depending on the direction the player is facing
			offset_from_player.x = facing_direction.x * 8 # Adjust the 50 value for desired distance
			global_position = player.global_position + offset_from_player
			
			# Optional: Drop object if another button is pressed (example: right-click)
			if Input.is_action_just_pressed("ui_cancel"):
				is_being_picked_up = false
