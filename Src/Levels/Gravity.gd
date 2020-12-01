extends Area2D

var luna setget luna_set
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func luna_set(Luna):
	luna = Luna
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_Gravity_body_entered(body):
#	body.planet_set(get_parent())
#	print(get_parent().name)
