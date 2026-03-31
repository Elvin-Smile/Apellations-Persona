extends AccompliceGuy
@onready var jan : AnimationPlayer = $Jan;
@onready var cutura : TextMaker = $Lovro/Cutura;
@onready var borna : Sprite2D = $Lovro/Borna;
@onready var gabric : Sprite2D = $Lovro/Gabric;
@onready var petrikovic : Sprite2D = $Petrikovic;

const animation_list : Array = ["_up", "_down", "_left", "_right"];
const frame_list : Array = [4, 1, 7, 10];

func _ready():
	super._ready();
	petrikovic.frame = mpg.current_animation*3+1;
	if (petrikovic.frame == 1): petrikovic.frame = 4;
	elif (petrikovic.frame == 4): petrikovic.frame = 1;
	gabric.show();
	borna.show();
	update_clock(cutura, gabric);

func _on_standing(dirc: int) -> void:
	jan.play("idle"+animation_list[dirc]);
func _on_walking(dirc: int) -> void:
	jan.play("walk"+animation_list[dirc]);
