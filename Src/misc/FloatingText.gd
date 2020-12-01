extends Position2D

onready var label = $Label
onready var tween = $Tween
var amount = 0
var type = ""
var pop = ""

func _ready():
	var t_rotation = get_global_rotation()
	t_rotation = clamp(t_rotation, 0, 0)
	global_rotation = t_rotation
	label.set_text(str(amount))
	match type:
		"Add":
			label.set("custom_colors/font_color", Color("2eff27"))
		"Subtract":
			label.set("custom_colors/font_color", Color("ff0000"))
			
	match pop:
		"temp":
			tween.interpolate_property(self, "scale", scale, Vector2(1,1), 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		"points":
			tween.interpolate_property(self, "scale", Vector2(1,1), Vector2(2,2), 3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.interpolate_property(self, "scale", Vector2(2,2), Vector2(0.1,0.1), 3, Tween.TRANS_LINEAR, Tween.EASE_OUT, 3)
	tween.start()


func _on_Tween_tween_all_completed():
	queue_free()
