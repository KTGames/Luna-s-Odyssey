extends Node2D

onready var luna setget luna_set
var planets setget planets_set

func luna_set(luna):
	luna = luna
	print(luna)
	global_position.x = luna.get_node("RigidBody2D").global_position.x-90
	global_position.y = luna.get_node("RigidBody2D").global_position.y+350
	luna.get_parent().add_child(self)
	$Area2D/Camera2D.make_current()
	luna.queue_free()
	expload()
	
func planets_set(Lplanets):
	planets = Lplanets
	for node in get_children():
		if node.get_class() == "RigidBody2D":
			node.planets_set(planets)

func expload():
	for node in get_children():
		if node.get_class() == "RigidBody2D":
			node.linear_velocity = Vector2(rand_range(-200,200),rand_range(-200,200))
