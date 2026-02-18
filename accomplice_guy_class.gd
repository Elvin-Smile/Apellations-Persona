@icon("res://accomplice_guy_icon.png")
extends Guy
class_name AccompliceGuy

const pixel_speed : int = 1;
const tile_size : int = 16;
const movement_delay : int = 5;
var coordinate : Vector2 = Vector2.ZERO;
var goal : Vector2 = Vector2.ZERO;
var movement : Vector2 = Vector2.ZERO;
var delta_movement_time = movement_delay;
var moving : bool = false;
var huh : bool = false;

func _ready():
	pass;

#preraditi sve!!!!!!!

func _process(_delta):
	if ((position == goal) and (delta_movement_time >= movement_delay)):
		goal.y += Input.get_axis("Up", "Down")*tile_size;
		movement.x = 0; movement.y = Input.get_axis("Up", "Down")*pixel_speed;
		moving = true;
	if ((position == goal) and (delta_movement_time >= movement_delay)):
		goal.x += Input.get_axis("Left", "Right")*tile_size;
		movement.x = Input.get_axis("Left", "Right")*pixel_speed; movement.y = 0;
		moving = true;

func _physics_process(_delta):
	huh = moving;
	if (!moving):
		delta_movement_time += 1;
		if (delta_movement_time > movement_delay): delta_movement_time = movement_delay;
	
	if (huh): delta_movement_time += 1;
	if (huh): position += movement;
	if (position == goal):
		if (moving): delta_movement_time = 0;
		moving = false;
		movement = Vector2.ZERO;
