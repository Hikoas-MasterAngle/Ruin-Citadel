extends Area2D
var held: bool = false  # To check if the orb is being held
var offset: Vector2 = Vector2.ZERO  # To store the relative offset when picking up the orb

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
#		if event.button_index == MouseButton.LEFT:  # Left-click
			if event.pressed:
				if get_global_mouse_position().distance_to(global_position) < 1:  # Radius check for clicking
					held = true
					offset = global_position - get_global_mouse_position()
			else:
				held = false

func _process(delta: float) -> void:
	if held:
		global_position = get_global_mouse_position() + offset
