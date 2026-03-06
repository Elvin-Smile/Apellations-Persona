extends OptionList

var previous_scene : String = "res://0z_Scenes/guy's.tscn";

func _process(_delta):
	super._process(_delta);
	if ((Input.is_action_just_pressed("Cancel")) or (Input.is_action_just_pressed("Menu"))):
		get_tree().change_scene_to_file(previous_scene);
