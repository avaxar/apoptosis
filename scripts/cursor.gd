extends Sprite2D


var held := false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				held = true
			else:
				held = false


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _process(_delta: float) -> void:
	global_position = get_viewport().get_mouse_position()
	if held and not %PlayerBubble.popped:
		var factor: float = %Player.calculate_bubble_factor(Time.get_unix_time_from_system() - %Player.last_mouse_click)
		position += (Vector2(randf() - 0.5, randf() - 0.5)) * 10.0 * (factor ** 2)
		modulate = Color(1.0, 1.0 - factor, 1.0 - factor, 1.0);
		%Player/Gun.offset += (Vector2(randf() - 0.5, randf() - 0.5)) * 5.0 * (factor ** 2)
	else:
		modulate = Color(1.0, 1.0, 1.0, 1.0);
