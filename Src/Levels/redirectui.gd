extends Sprite
onready var lunaRB = get_parent()
onready var arrow = $redirectuiarrow
var angle
var can_redirect

func _ready():
	can_redirect = false

func _process(delta):
	if visible:
		var pos = lunaRB.global_position + lunaRB.linear_velocity
		look_at(pos)
		angle = rad2deg(get_angle_to(get_global_mouse_position()))
		if angle > -60 && angle < 60:
			arrow.look_at(get_global_mouse_position())
			can_redirect = true
			arrow.texture = load("res://Assets/redirectuiarrow.png")
		else:
			can_redirect = false
			arrow.texture = load("res://Assets/redirectuiarrowred.png")
