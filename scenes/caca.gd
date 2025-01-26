extends Node2D

const Caca_pos = Vector2(0, 0)



var speed: float
const start_speed: float = 4.0 
const max_speed: float = 20.0 


func start_game():
	$Caca.position = Vector2(0,0) 

	
# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	speed = start_speed
	
	if $Caca.position.y > 350:
		$Caca.position.y = 30
	if $Caca.position.y > 1450:
		$Caca.position.y = 30
