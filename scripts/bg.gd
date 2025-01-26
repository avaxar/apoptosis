extends Node2D

#const wall_start_pos = Vector2(-150, 8)
#const wall_start_pos2 = Vector2(1425, 8)
const background_pos2 = Vector2(0, 0)
const midground_pos = Vector2(0,0)

var speed: float
const start_speed: float = 4.0 
const max_speed: float = 20.0 


func start_game():
	#$wall1.position = wall_start_pos 
	#$wall2.position = wall_start_pos2
	$background.position = background_pos2
	$midground.position = midground_pos	
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	speed = start_speed
	
	#$wall1.position.y += speed * 0.8
	#$wall2.position.y += speed * 0.8 
	$background.position.y += speed *0.3
	$midground.position.y += speed *0.1
		
	#if $wall1.position.y > 1440:
		#$wall1.position.y = 8
	#if $wall2.position.y > 1440:
		#$wall2.position.y = 8
	if $background.position.y > 725:
		$background.position.y = -55
	if $midground.position.y > 720:
		$midground.position.y = -112
		
