@icon("res://guy_icon.png")
extends CharacterBody2D
class_name Guy

const clock_position : Vector2 = Vector2(57, -88);
var date_to_print : String = "";

func _process(_delta):
	pass;

func update_clock(maker : TextMaker, spriter : Sprite2D):
	spriter.texture = load("res://UI/"+gv.time_names[gv.current_time]+"_v00.png");
	spriter.position = Vector2(117+float(spriter.texture.get_width())/2, -90+float(spriter.texture.get_height())/2);
	date_to_print = "";
	if (gv.current_date < 10): date_to_print += " ";
	date_to_print += str(gv.current_date)+"ˇ";
	if (gv.current_month < 10): date_to_print += " ";
	date_to_print+= str(gv.current_month);
	maker.make_text(date_to_print, "Short_Double_Basic", clock_position, Vector2(clock_position.x+5000, clock_position.y+5000), 0, 1000);
	maker.make_text(gv.day_names_short[gv.current_day], "Short_Double_Basic", Vector2(clock_position.x, clock_position.y+tm.line_size["Short_Double_Basic"]), Vector2(clock_position.x+5000, clock_position.y+5000), 1, 1000);
