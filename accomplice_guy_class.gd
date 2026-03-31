@icon("res://accomplice_guy_icon.png")
extends Guy
class_name AccompliceGuy

#kod je za lika dok je u normalnom svijetu
#mice se po gridu
#ima vrijeme koje treba proci izmedu pokretaja
#ako samo kliknes gumb, okrene se u smjeru kretanja, a ak ga drzis hoda u njemu

signal walking(dirc : int);
signal standing(dirc : int);

const pixel_speed : int = 1;
const movement_delay : float = 0.1;
const pressquo : float = 8;
const pressmin : float = 1;

var inpaxis : float = 0;

var delta_movement_time = movement_delay;
var movement : Vector2 = Vector2.ZERO;
var moving : bool = false;
var presscount : Array = [0, 0, 0, 0];

func _ready():
	mpg.coordinate = mpg.goal;
	position = mpg.coordinate;


func _process(delta):
	super._process(delta);
	
	if (Input.is_action_just_pressed("Menu")):
		if (moving):
			mpg.coordinate = mpg.goal;
			position = mpg.goal;
		get_tree().change_scene_to_file("res://0z_Scenes/pause_menu.tscn");
	
	
	if ((position == mpg.goal) and (delta_movement_time >= movement_delay)):
		inpaxis = Input.get_axis("Up", "Down");
		#provjeri dal se mozes kretati
		if ((presscount[0.5*inpaxis+0.5] < pressquo) and (inpaxis != 0)):
			if (presscount[0.5*inpaxis+0.5] >= pressmin):
				mpg.current_animation = 0.5*inpaxis+0.5;
				standing.emit(mpg.current_animation);
			inpaxis = 0;
		#pokrene movement
		mpg.goal.y += inpaxis*gv.tile_size;
		movement.x = 0; movement.y = inpaxis*pixel_speed;
		moving = true;
		if (movement.y):
			mpg.current_animation = 0.5+movement.y*0.5;
			walking.emit(mpg.current_animation);
			
	if ((position == mpg.goal) and (delta_movement_time >= movement_delay)):
		inpaxis = Input.get_axis("Left", "Right");
		#provjeri dal se moze kretati
		if ((presscount[0.5*inpaxis+2.5] < pressquo) and (inpaxis != 0)):
			if (presscount[0.5*inpaxis+2.5] >= pressmin):
				mpg.current_animation = 0.5*inpaxis+2.5;
				standing.emit(mpg.current_animation);
			inpaxis = 0;
		#pokrene movement
		mpg.goal.x += inpaxis*gv.tile_size;
		movement.x = inpaxis*pixel_speed; movement.y = 0;
		moving = true;
		if (movement.x):
			mpg.current_animation = 2.5+movement.x*0.5;
			walking.emit(mpg.current_animation);

func _physics_process(delta):
	#gleda kolko dugo si drzao gumb u nekom smjeru, vjerovatno je moglo bit napravljeno jednostavnije
	inpaxis = Input.get_axis("Up", "Down");
	if (inpaxis > 0): presscount[1] += 1; presscount[0] = 0;
	elif (inpaxis < 0): presscount[0] += 1; presscount[1] = 0;
	else: presscount[0] = 0; presscount[1] = 0;
	inpaxis = Input.get_axis("Left", "Right");
	if (inpaxis > 0): presscount[3] += 1; presscount[2] = 0;
	elif (inpaxis < 0): presscount[2] += 1; presscount[3] = 0;
	else: presscount[3] = 0; presscount[2] = 0;
	
	#provjeri dal si stigo na odrediste
	if (position == mpg.goal):
		if (moving):
			delta_movement_time = 0;
			standing.emit(mpg.current_animation);
		moving = false;
		movement = Vector2.ZERO;
		mpg.coordinate = position;
		
	#poveca vrijeme izmedu kretanja
	if (!moving):
		delta_movement_time += 1*delta;
		if (delta_movement_time > movement_delay): delta_movement_time = movement_delay;
	else:
		delta_movement_time += 1;
	
	move_and_collide(movement);
