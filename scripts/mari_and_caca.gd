extends Node2D


var speed: float
const start_speed: float = 4.0 
const max_speed: float = 20.0 


func start_game():
	$caca.position = Vector2(0, 0)
	$mari.position = Vector2(305, 300)	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	speed = start_speed
	
	$caca.position.y -= speed * 0.29
	$mari.position.y -= speed * 0.22

	
	if $caca.position.y <= -400:
		$caca.position.y = 750
	if $mari.position.y <= -500:
		$mari.position.y = 750
