extends MarginContainer


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_main_menu_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
