extends LocationMan



func _on_interacting(inter_name : String):
	match inter_name:
		"<House":
			print("hello");
