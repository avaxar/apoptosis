class_name Pellet

extends AnimatedSprite2D

@onready var sphere := $Area2D/Sphere
@onready var timer := $Timer

var radius: float:
	get:
		return sphere.shape.radius
	set(new):
		sphere.shape.radius = new
var MIN_RADIUS := 10.0
var MAX_RADIUS := 150.0

var air: float = 30.0:
	get:
		return (radius - MIN_RADIUS) / (MAX_RADIUS - MIN_RADIUS) * 100.0
	set(new):
		radius = lerp(MIN_RADIUS, MAX_RADIUS, new / 100.0);

const DRAG := 100.0
var velocity: Vector2
var player_made := false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	scale = Vector2(1.0, 1.0) * radius / 56.0 * 2.0

	velocity.y -= DRAG * delta
	position += velocity * delta


var popped := false
func pop() -> void:
	if popped:
		return
	
	play("pop")
	timer.start()
	popped = true


func _on_area_entered(area) -> void:
	print(area, " entered")
	var parent = area.get_parent()

	if parent is Pellet:
		if parent.player_made and self == get_node_or_null("%PlayerBubble"):
			return
		if not parent.player_made and self != get_node_or_null("%PlayerBubble"):
			return
		parent.pop()

	pop()


func _on_timer_timeout() -> void:
	queue_free()
