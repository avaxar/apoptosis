class_name Bubble

extends Area2D


@onready var sphere := $Sphere
@onready var tiles := $Tiles
@onready var sprite := $Sprite

var radius: float:
	get:
		return sphere.shape.radius
	set(new):
		sphere.shape.radius = new
var MIN_RADIUS := 40.0
var MAX_RADIUS := 85.0

var air: float:
	get:
		return (radius - MIN_RADIUS) / (MAX_RADIUS - MIN_RADIUS) * 100.0
	set(new):
		radius = lerp(MIN_RADIUS, MAX_RADIUS, new / 100.0);

var velocity: Vector2
var rot_velocity: float
var in_player: bool


func _ready() -> void:
	air = 50.0


func _process(delta: float) -> void:
	#air = sin(Time.get_ticks_msec() / 1000.0) * 50.0 + 50.0;

	tiles.position.y = radius
	sprite.scale = Vector2(1.0, 1.0) * radius / 56.0 * 2.0
	
	if popped:
		velocity.y += 50.0 * delta
	elif air < 0.0 or air > 100.0:
		pop()

	if self == %PlayerBubble:
		const LEFT_WALL := 150.0
		if position.x - radius < LEFT_WALL:
			velocity.x *= -1
			position.x = radius + LEFT_WALL

		const RIGHT_WALL := 1130
		if position.x + radius > RIGHT_WALL:
			velocity.x *= -1
			position.x = RIGHT_WALL - radius

	velocity -= velocity * 0.32 * delta
	position += velocity * delta
	rotation += rot_velocity * delta


var popped := false
func pop() -> void:
	if popped:
		return

	sphere.set_deferred("disable", true)
	sprite.play("pop")
	rot_velocity = (randf() - 0.5) * PI
	popped = true
	
	if self == %PlayerBubble:
		%Player.call_deferred("reparent", get_parent())


func _on_area_entered(area) -> void:
	print(area, " entered")
	var parent = area.get_parent()

	if parent is Pellet:
		if parent.player_made and self == %PlayerBubble:
			return
		parent.pop()

	pop()


func _on_area_exited(area) -> void:
	print(area, " exited")
