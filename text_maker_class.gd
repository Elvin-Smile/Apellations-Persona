@icon("res://text_maker_icon.png")
extends Node
class_name TextMaker

const line_size : int = 14;
const letter_path : String = "res://Fonts/";
var word_size : Array = [];
var letter_sprite_path : String;
var letter_image : CompressedTexture2D;
var letter_length : int = 0;
var trenutna_duljina : int = 0;
var cursor_position : Vector2 = Vector2.ZERO;
var letter_sprite : Sprite2D;
var child_adder : Node2D = Node2D.new();
var current_word : int = 0;
var last_one : String = " ";

func _ready():
	make_text("i l a", "Basic", Vector2(100, 100), Vector2(400, 500), 0, 0);
	pass;

func make_text(text : String = "", font : String = "", start_position : Vector2 = Vector2.ZERO, end_position : Vector2 = Vector2(200, 200), index : int = 0, zvalue : int = 0):
	#zamijeni child s novim
	remove_child(get_child(index));
	add_child(child_adder);
	move_child(get_child(get_child_count()-1), index);
	trenutna_duljina = 0;
	cursor_position = start_position;
	word_size = [];
	#dobiva word length
	for i in text:
		if ((i == " ") or (i == "~")):
			print("trenutna duljina je ", trenutna_duljina);
			word_size.append(trenutna_duljina);
			print("array je", word_size);
			trenutna_duljina = 0;
		else:
			letter_sprite_path = letter_path+font+"/"+i+".png";
			letter_image = load(letter_sprite_path);
			trenutna_duljina += letter_image.get_width();
		last_one = i;
	if ((last_one != " ") and (last_one != "~")): word_size.append(trenutna_duljina);
	#pisanje slova
	
	current_word = 0;
	for i in text:
		#provede razmak i provjeri dal može nastavit dalje
		if ((i == " ") or (i == "~")): current_word += 1;
		if (i == " "):
			cursor_position.x += 3;
			if (cursor_position.x+word_size[current_word] > end_position.x): cursor_position = Vector2(start_position.x, cursor_position.y+line_size);
		elif (i == "~"): cursor_position = Vector2(start_position.x, cursor_position.y+line_size);
		#napravi novi sprite i doda ga kao dijete dijeteta i postavi ga kao slovo
		else:
			letter_image = load(letter_path+font+"/"+i+".png");
			letter_sprite = Sprite2D.new();
			letter_sprite.texture = letter_image;
			letter_sprite.position = cursor_position;
			letter_sprite.z_index = zvalue;
			get_child(index).add_child(letter_sprite);
			cursor_position.x += letter_image.get_width()+1;

func delete_text(index : int = 0, child_number : int = 1):
	add_child(Node2D.new());
	move_child(get_child(child_number-1), (index))
	remove_child(get_child(index+1));
