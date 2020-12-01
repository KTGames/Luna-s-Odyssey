extends TextureRect




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	set_global_position(get_local_mouse_position()/56)
