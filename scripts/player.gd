extends CharacterBody2D


@onready var sprite = $AnimatedSprite2D
@onready var gun = $Gun

const SPEED := 32.0
const JUMP_VEL := 80.0
const GRAVITY := 80.0


func _process(delta: float) -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y -= JUMP_VEL
	else:
		velocity.y += GRAVITY * delta;

	var direction := Input.get_axis("move_left", "move_right")
	if direction < 0.0:
		sprite.flip_h = true
		gun.offset = Vector2(-3.25, -2.68)
	elif direction > 0.0:
		sprite.flip_h = false
		gun.offset = Vector2(3.25, -2.68)
	gun.flip_h = sprite.flip_h;

	if direction:
		velocity.x = direction * SPEED
		sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
		sprite.play("idle")

	move_and_slide()


var last_mouse_click: float
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				last_mouse_click = Time.get_unix_time_from_system()
			else:
				shoot_bubble(event.position, Time.get_unix_time_from_system() - last_mouse_click)

func calculate_bubble_factor(time: float) -> float:
	const MIN_TIME := 0.2
	const MAX_TIME := 1.5
	return clamp((time - MIN_TIME) / (MAX_TIME - MIN_TIME), 0.0, 1.0)


func calculate_bubble_speed(time: float) -> float:
	const MIN_SPEED := 150.0
	const MAX_SPEED := 1050.0
	return lerp(MIN_SPEED, MAX_SPEED, calculate_bubble_factor(time))


func calculate_bubble_air(time: float) -> float:
	const MIN_AIR := 2.5
	const MAX_AIR := 20.0
	return lerp(MIN_AIR, MAX_AIR, calculate_bubble_factor(time))


var bubble_pellet := preload("res://scenes/pellet.tscn")
func shoot_bubble(target: Vector2, time: float):
	const MIN_TIME := 0.2
	if (time < MIN_TIME):
		return
	
	var pellet := bubble_pellet.instantiate()
	%Pellets.add_child(pellet)
	pellet.velocity = (target - global_position).normalized() * calculate_bubble_speed(time)
	pellet.air = calculate_bubble_air(time)
	pellet.player_made = true
	pellet.global_position = global_position
	
	%PlayerBubble.velocity += -pellet.velocity * 0.25
