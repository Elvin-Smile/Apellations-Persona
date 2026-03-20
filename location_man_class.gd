@icon("res://location_man_icon.png")
extends Node2D
class_name LocationMan

const max_size_h = 5000;
const idk : Array = [Vector2(0, -gv.tile_size), Vector2(0, gv.tile_size), Vector2(-gv.tile_size, 0), Vector2(gv.tile_size, 0)]
var interacts : Array;
var enters : Array;
var current_child : String;
var appendant : Array;


signal interacting(inter_name : String);

func is_next_to(vekter : Vector2) -> bool:
	if (Vector2(mpg.coordinate.x+idk[mpg.current_animation].x, mpg.coordinate.y+idk[mpg.current_animation].y) == vekter): return true;
	else: return false;

func _ready():
	for i in range(0, max_size_h*2):
		appendant.append("*");
	for i in range(0, max_size_h*2):
		interacts.append(appendant);
		enters.append(appendant);
	for i in get_children():
		current_child = i.name;
		if (current_child[0] == ">"):
			interacts[i.position.y+max_size_h][i.position.x+max_size_h] = i.name;
		if (current_child[0] == "<"):
			enters[i.position.y+max_size_h][i.position.x+max_size_h] = i.name;
		

func _process(_delta):
	if (Input.is_action_just_pressed("Confirm")):
		current_child = interacts[int(mpg.coordinate.y+idk[mpg.current_animation].y)][int(mpg.coordinate.x+idk[mpg.current_animation].x)]
		if (interacts[int(mpg.coordinate.y+idk[mpg.current_animation].y+max_size_h)][int(mpg.coordinate.x+idk[mpg.current_animation].x+max_size_h)][0] == ">"):
			interacting.emit(interacts[int(mpg.coordinate.y+idk[mpg.current_animation].y+max_size_h)][int(mpg.coordinate.x+idk[mpg.current_animation].x)]+max_size_h);
		if (str(interacts[int(mpg.coordinate.y+max_size_h)][(mpg.coordinate.x+max_size_h)])[0] == "<"):
			interacting.emit(enters[int(mpg.coordinate.y+max_size_h)][int(mpg.coordinate.x+max_size_h)]);
