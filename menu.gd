extends Control

func _ready() -> void:
	$MenuMusic.play()
	$Menu.visible = false
	$Names.visible = 0
	




func _on_play_pressed() -> void:
	$Click.play()
	get_tree().change_scene_to_file("res://scenes/intro.tscn")


func _on_credits_button_up() -> void:
	$MarginContainer.visible = 0
	$Node.visible = 0
	$Menu.visible = 1
	$Names.visible = 1
	$Click.play()


func _on_menu_button_up() -> void:
	$MarginContainer.visible = 1
	$Node.visible = 1
	$Menu.visible = 0
	$Names.visible = 0
	$Click.play()
