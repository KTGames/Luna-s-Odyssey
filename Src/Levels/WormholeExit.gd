extends Node2D

var Mass setget Mass_set, Mass_get
var whRad setget whRad_set, whRad_get
var ID = "WormholeExit"

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



