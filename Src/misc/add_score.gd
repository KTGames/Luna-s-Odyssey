extends Position2D

onready var label = $Label
onready var anim = $AnimationPlayer
var amount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var t_rotation = get_global_rotation()
	t_rotation = clamp(t_rotation, 0, 0)
	global_rotation = t_rotation
	label.set_text("+" + str(amount))

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
