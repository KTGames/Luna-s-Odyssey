extends Node2D

onready var rg1 = $RigidBody2D/Camera2D
onready var rg2 = $RigidBody2D2/Camera2D
onready var rg3 = $RigidBody2D3/Camera2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(false)
	set_process_unhandled_input(false)
	rg1.shake(10, 20, 10)
	rg2.shake(10, 20, 10)
	rg3.shake(10, 20, 10)
	for rb in get_children():
		rb.linear_velocity = Vector2(200,0)
		print(rb.linear_velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
