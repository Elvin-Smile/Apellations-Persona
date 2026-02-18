extends OptionList

func button_press():
	pass;

func _process(delta):
	super._process(delta);
	if (Input.is_action_just_pressed("Confirm")):
		match (pointer):
			#Load game
			0:
				pass;
			#New Game
			1:
				get_tree().change_scene_to_file("res://0z_Scenes/guy's.tscn");
				pass;
			2:
				pass;
			3:
				pass;
			4:
				pass;
			5:
				pass;
