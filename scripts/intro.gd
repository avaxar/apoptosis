extends Node2D


var time := 0.0
func _process(delta: float) -> void:
	time += delta

	# I HAVE NO IDEA HOW TO USE ANIMATION PLAYERS
	for i in range(1, 9):
		var frame := get_node(str(i))
		var x := clampf(time / 2.5 - i + 1.0, 0.0, 1.0)
		if frame.modulate.a == 0.0 and x > 0.0:
			match i:
				pass

		frame.modulate.a = x

	if Input.is_action_just_pressed("jump"):
		time += 2.5
		if time >= 17.5:
			get_tree().change_scene_to_file("res://scenes/level.tscn")
