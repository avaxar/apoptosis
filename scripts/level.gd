extends Node2D


var progression := 0.0
@export var game_time := 180.0
var game_pace := 100.0 / game_time
@export var map_size := 15000.0


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	progression += game_pace * delta

	if progression >= 100.0:
		get_tree().change_scene_to_file("res://scenes/victory_cutscene.tscn")
	elif progression >= 95.0:
		var x := ((progression - 95.0) / 5.0) ** 2
		%FillColor.modulate = Color(1.0, 1.0, 1.0, x)
		%WorldEnvironment.environment.glow_bloom = x

	%HeightBar/Mari.global_position = lerp(Vector2(1192.0, 688.0),
										   Vector2(1192.0, 32.0), progression / 100.0)
	%HeightBar/Caca.global_position = lerp(Vector2(1192.0, 688.0),
										   Vector2(1192.0, 32.0),
										   progression / 100.0 - ((progression / 100.0) ** 2 - 1) / 5)

	%Map.position.y = progression / 100.0 * map_size
	
	if %Player.global_position.y >= 720:
		var x: float = ((%Player.global_position.y - 720.0) / 144.0)
		if x <= 0.8:
			%FillColor.modulate = Color(1.0, 0.0, 0.0, x / 0.8)
		else:
			var y := ((x - 0.8) * 5.0) ** 2
			%FillColor.modulate = Color(1.0 - y, 0.0, 0.0, 1.0)
		#%WorldEnvironment.environment.glow_bloom = x
		if x >= 1.0:
			get_tree().change_scene_to_file("res://scenes/death.tscn")
