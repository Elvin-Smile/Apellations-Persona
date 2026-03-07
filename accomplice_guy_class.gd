@icon("res://accomplice_guy_icon.png")
extends Guy
class_name AccompliceGuy

signal walking(dirc : int);
signal standing(dirc : int);

const pixel_speed : int = 1;
const movement_delay : int = 5;
var movement : Vector2 = Vector2.ZERO;
var delta_movement_time = movement_delay;
var moving : bool = false;
var huh : bool = false;

func _ready():
	mpg.coordinate = mpg.goal;
	position = mpg.coordinate;


func _process(_delta):
	super._process(_delta);
	
	if (Input.is_action_just_pressed("Menu")):
		if (moving):
			mpg.coordinate = mpg.goal;
			position = mpg.goal;
		get_tree().change_scene_to_file("res://0z_Scenes/pause_menu.tscn");
		
	if ((position == mpg.goal) and (delta_movement_time >= movement_delay)):
		mpg.goal.y += Input.get_axis("Up", "Down")*gv.tile_size;
		print(mpg.goal.y);
		movement.x = 0; movement.y = Input.get_axis("Up", "Down")*pixel_speed;
		moving = true;
		if (movement.y):
			mpg.current_animation = 0.5+movement.y*0.5;
			walking.emit(mpg.current_animation);
	if ((position == mpg.goal) and (delta_movement_time >= movement_delay)):
		mpg.goal.x += Input.get_axis("Left", "Right")*gv.tile_size;
		movement.x = Input.get_axis("Left", "Right")*pixel_speed; movement.y = 0;
		moving = true;
		if (movement.x):
			mpg.current_animation = 2.5+movement.x*0.5;
			walking.emit(mpg.current_animation);

func _physics_process(_delta):
	huh = moving;
	if (!moving):
		delta_movement_time += 1;
		if (delta_movement_time > movement_delay): delta_movement_time = movement_delay;
	
	if (huh): delta_movement_time += 1;
	if (huh): position += movement;
	if (position == mpg.goal):
		if (moving):
			delta_movement_time = 0;
			standing.emit(mpg.current_animation);
			
		moving = false;
		movement = Vector2.ZERO;
		mpg.coordinate = position;
