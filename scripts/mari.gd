extends Node2D

const Mari_pos = Vector2(0, 0)



var speed: float
const start_speed: float = 4.0 
const max_speed: float = 20.0 


func start_game():
	$Mari.position = Mari_pos 

	
# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	speed = start_speed
	


	
	if $Mari.position.y >= 350:
		$Mari.position.y += speed * 0.3
	if $Mari.position.y <= 0:
		$Mari.position.y = 30
