@icon("res://guy_icon.png")
extends CharacterBody2D
class_name Guy

func _process(_delta):
	if (Input.is_action_just_pressed("Menu")):
		get_tree().change_scene_to_file("res://0z_Scenes/pause_menu.tscn");
