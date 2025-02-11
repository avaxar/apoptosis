extends Node2D


@export_range(0.0, 100.0) var init_air: float = 50.0
@export var pellet_interval: float = 2.0
@export var pellet_velocity: Vector2 = Vector2(250.0, 0.0)
@export_range(0.0, 100.0) var pellet_air: float = 10.0

@onready var bubble := $Bubble
@onready var enemy := $Bubble/Enemy
@onready var timer := $Timer


func _ready() -> void:
	bubble.air = init_air
	timer.wait_time = pellet_interval
	
	var color := randi_range(0b001, 0b111)
	const COLOR_FACTOR := 0.45
	enemy.modulate = Color((color & 0b001) * COLOR_FACTOR,
						   (color & 0b010) * COLOR_FACTOR,
						   (color & 0b100) * COLOR_FACTOR)


func _process(delta: float) -> void:
	if not enemy.is_on_floor():
		const GRAVITY := 60.0
		enemy.velocity.y += GRAVITY * delta;
	enemy.move_and_slide()
	
	if bubble.popped:
		timer.stop()


var bubble_pellet := preload("res://scenes/pellet.tscn")
func _on_timer_timeout() -> void:
	var pellet := bubble_pellet.instantiate()
	%Pellets.add_child(pellet)
	pellet.velocity = pellet_velocity * scale
	pellet.air = pellet_air
	pellet.global_position = enemy.global_position
	#$Shoot.play()
