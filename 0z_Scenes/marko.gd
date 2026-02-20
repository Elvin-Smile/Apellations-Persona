extends AccompliceGuy

const animation_list : Array = ["_up", "_down", "_left", "_right"];
@onready var smalcelj : AnimationPlayer = $Jan;

func _on_standing(dirc: int) -> void:
	smalcelj.play("idle"+animation_list[dirc]);



func _on_walking(dirc: int) -> void:
	smalcelj.play("walk"+animation_list[dirc]);
