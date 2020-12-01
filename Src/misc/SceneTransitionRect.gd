extends TextureRect


onready var anim := $anim


# Called when the node enters the scene tree for the first time.
func _ready()  -> void:
	anim.play_backwards("fade_out")
	hide()

func transition_to(number = 0) -> void:
	anim.play("fade_out")
