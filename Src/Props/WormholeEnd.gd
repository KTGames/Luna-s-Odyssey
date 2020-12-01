extends Node2D

signal cutscene_shit

var Mass setget Mass_set, Mass_get
var whRad setget whRad_set, whRad_get
var whExit 
var ID = "WormholeEnter"

func _ready():
	Mass_set(1000)
	whRad_set($CollisionShape2D.shape.radius)
	

func Mass_set(mass):
	Mass = mass
	print(Mass)

func Mass_get():
	return Mass
	
func whRad_set(rad):
	whRad = rad
	print(whRad)

func whRad_get():
	return whRad

func _on_Level_End_body_entered(body):
	if body.is_in_group("Luna"):
		var level = body.get_parent().get_parent()
		body.get_parent().get_node("Line2D").hide()
		level.flag = false
		body.queue_free()
		Events.emit_signal("end_level")
		
