extends Control

onready var label = get_node("HBoxContainer/Label")
onready var label2 = get_node("HBoxContainer/Label2")
var max_pickups
var got_pickups

func _ready():
	Global.got_pickups = 0

func _process(delta):
	max_pickups = Global.max_pickups
	got_pickups = Global.got_pickups
	label2.text = str(max_pickups)
	label.text = str(got_pickups)
