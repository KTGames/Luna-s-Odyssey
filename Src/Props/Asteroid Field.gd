extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for textrect in get_children():
		textrect.texture = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
