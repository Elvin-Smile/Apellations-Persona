extends AccompliceGuy
@onready var jan : AnimationPlayer = $Jan
@onready var cutura : TextMaker = $Lovro/Cutura
@onready var borna : Sprite2D = $Lovro/Borna
@onready var gabric : Sprite2D = $Lovro/Gabric
@onready var petrikovic : Sprite2D = $Petrikovic
@onready var maks : RayCast2D = $Maks

#kod je za lika dok je u normalnom svijetu
#mice se po gridu
#ima vrijeme koje treba proci izmedu pokretaja
#ako samo kliknes gumb, okrene se u smjeru kretanja, a ak ga drzis hoda u njemu

const animation_list : Array = ["_up", "_down", "_left", "_right"];
const frame_list : Array = [4, 1, 7, 10];
const pixel_speed : int = 1;
const movement_delay : float = 0.1;
const pressquo : float = 8;
const pressmin : float = 1;
const director : Array = [Vector2(0, -1), Vector2(0, 1), Vector2(-1, 0), Vector2(1, 0)];

var inpaxis : float = 0;

var delta_movement_time = movement_delay;
var movement : Vector2 = Vector2.ZERO;
var moving : bool = false;
var presscount : Array = [0, 0, 0, 0];



func standing(dirc: int):
	jan.play("idle"+animation_list[dirc]);
func walking(dirc: int):
	jan.play("walk"+animation_list[dirc]);


func _ready():
	mpg.coordinate = mpg.goal;
	position = mpg.coordinate;
	petrikovic.frame = mpg.dirc*3+1;
	if (petrikovic.frame == 1): petrikovic.frame = 4;
	elif (petrikovic.frame == 4): petrikovic.frame = 1;
	gabric.show();
	borna.show();
	update_clock(cutura, gabric);


func _physics_process(delta):
	maks.target_position = director[mpg.dirc]*gv.tile_size;
	#gleda kolko dugo si drzao gumb u nekom smjeru, vjerovatno je moglo bit napravljeno jednostavnije
	inpaxis = Input.get_axis("Up", "Down");
	if (inpaxis > 0): presscount[1] += 1; presscount[0] = 0;
	elif (inpaxis < 0): presscount[0] += 1; presscount[1] = 0;
	else: presscount[0] = 0; presscount[1] = 0;
	inpaxis = Input.get_axis("Left", "Right");
	if (inpaxis > 0): presscount[3] += 1; presscount[2] = 0;
	elif (inpaxis < 0): presscount[2] += 1; presscount[3] = 0;
	else: presscount[3] = 0; presscount[2] = 0;
	for i in range(0, 4):
		if (presscount[i] > 0):
			for j in range(0, 4):
				if (j != i):
					presscount[j] = 0;
			break;
	
	#provjeri dal si stigo na odrediste
	if (position == mpg.goal):
		if (moving):
			print("nyoho");
			delta_movement_time = 0;
			presscount = [0, 0, 0, 0];
			standing(mpg.dirc);
		moving = false;
		movement = Vector2.ZERO;
		mpg.coordinate = position;
	
	#poveca vrijeme izmedu kretanja
	if (!moving):
		delta_movement_time += 1*delta;
		if (delta_movement_time > movement_delay): delta_movement_time = movement_delay;
	else:
		position += movement;
	
	
func _process(delta):
	super._process(delta);
	
	if (Input.is_action_just_pressed("Menu")):
		if (moving):
			mpg.coordinate = mpg.goal;
			position = mpg.goal;
		get_tree().change_scene_to_file("res://0z_Scenes/pause_menu.tscn");
	
	
	if ((position == mpg.goal) and (delta_movement_time >= movement_delay) and (!moving)):
		inpaxis = Input.get_axis("Up", "Down");
		#provjeri dal se mozes kretati
		if ((presscount[0.5*inpaxis+0.5] < pressquo) and (inpaxis != 0)):
			if (presscount[0.5*inpaxis+0.5] >= pressmin):
				mpg.dirc = 0.5*inpaxis+0.5;
				standing(mpg.dirc);
			inpaxis = 0;
		maks.target_position = director[mpg.dirc]*gv.tile_size;
		if (maks.is_colliding()): inpaxis = 0;
			
		#pokrene movement
		mpg.goal.y += inpaxis*gv.tile_size;
		movement.x = 0; movement.y = inpaxis*pixel_speed;
		if (movement.y):
			moving = true;
			mpg.dirc = 0.5+movement.y*0.5;
			walking(mpg.dirc);
			
	if ((position == mpg.goal) and (delta_movement_time >= movement_delay) and (!moving)):
		inpaxis = Input.get_axis("Left", "Right");
		#provjeri dal se moze kretati
		if ((presscount[0.5*inpaxis+2.5] < pressquo) and (inpaxis != 0)):
			if (presscount[0.5*inpaxis+2.5] >= pressmin):
				mpg.dirc = 0.5*inpaxis+2.5;
				standing(mpg.dirc);
			inpaxis = 0;
		maks.target_position = director[mpg.dirc]*gv.tile_size;
		if (maks.is_colliding()): inpaxis = 0;
		#pokrene movement
		mpg.goal.x += inpaxis*gv.tile_size;
		movement.x = inpaxis*pixel_speed; movement.y = 0;
		if (movement.x):
			moving = true;
			mpg.dirc = 2.5+movement.x*0.5;
			walking(mpg.dirc);
