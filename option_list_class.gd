@icon("res://option_list_icon.png")
extends Control
class_name OptionList


var pointer : int = 0;
var button_num : int;

func _ready():
	#hidea sve osim prvog pointera
	button_num = get_child_count();
	get_child(0).show();
	for i in range(1, button_num):
		get_child(i).hide();
	print(button_num);

func _process(delta):
	#pointer selekcija
	if ((Input.is_action_just_pressed("Down")) or (Input.is_action_just_pressed("Right"))):
		get_child(pointer).hide();
		pointer = (pointer+1)%button_num;
		get_child(pointer).show();
	if ((Input.is_action_just_pressed("Up")) or (Input.is_action_just_pressed("Left"))):
		get_child(pointer).hide();
		pointer -= 1;
		if (pointer < 0):
			pointer = button_num-1;
		get_child(pointer).show();
