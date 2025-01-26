extends Node2D

const wall_start_pos = Vector2(-145, 0)
const wall_start_pos2 = Vector2(1420, 0)
const background_pos2 = Vector2(0, 0)
const midground_pos = Vector2(0,0)

var speed: float
const start_speed: float = 4.0 
const max_speed: float = 20.0 


func start_game():
	$wall1.position = wall_start_pos 
	$wall2.position = wall_start_pos2
	$background2.position = background_pos2
	$midground.position = midground_pos	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	speed = start_speed
	
	$wall1.position.y += speed * 0.5
	$wall2.position.y += speed * 0.5
	$background2.position.y += speed *0.4
	$midground.position.y += speed *0.3
	
	if $wall1.position.y > 1450:
		$wall1.position.y = 30
	if $wall2.position.y > 1450:
		$wall2.position.y = 30
	if $background2.position.y > 720:
		$background2.position.y = 0
	if $midground.position.y > 720:
		$midground.position.y = -120
