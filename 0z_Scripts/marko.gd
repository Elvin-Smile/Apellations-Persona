extends AccompliceGuy
@onready var jan : AnimationPlayer = $Jan;
@onready var cutura : TextMaker = $Lovro/Cutura;
@onready var gabric : Sprite2D = $Lovro/Gabric;

const animation_list : Array = ["_up", "_down", "_left", "_right"];

func _ready():
	update_clock(cutura, gabric);

func _on_standing(dirc: int) -> void:
	jan.play("idle"+animation_list[dirc]);
func _on_walking(dirc: int) -> void:
	jan.play("walk"+animation_list[dirc]);
