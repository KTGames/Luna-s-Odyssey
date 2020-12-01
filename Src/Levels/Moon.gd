extends Node2D
export var ID = "moon"
export var FGravity: Vector2
onready var Planets setget Planets_set
var Wormholes setget Wormholes_set
onready var moonRB = $RigidBody2D
var moon setget moon_set
var gvectors = {}
export var G = .3
var orbiting_planet
var starting_orbit

func _ready():
	moon_set(moonRB.get_node("CollisionShape2D").shape.radius*25)
	starting_orbit = false
	
func _physics_process(delta):
	if Planets != null:
		Set_Gravity_Vector(delta)
	if !starting_orbit:
		var orbSpeed = sqrt(moonRB.global_position.distance_to(orbiting_planet.global_position)*(orbiting_planet.Mass_get()*G))
		moonRB.linear_velocity = Vector2(orbSpeed,0)
		#moonRB.move_and_collide(Vector2(orbSpeed,0))
		starting_orbit = true
		#print(moonRB.linear_velocity)

func Wormholes_set(new_Wormholes):
	if Wormholes:
		Wormholes.clear()
	Wormholes = new_Wormholes

func Planets_set(new_Planets):
	if Planets:
		Planets.clear()
	Planets = new_Planets
	
		
func Calc_grav(planet):
	#F = G * (m1 * m2)/r^2
		var r = moonRB.global_position.distance_to(planet.global_position)
		var dir = moonRB.global_position-planet.global_position
		FGravity = (G * (planet.Mass_get() * moonRB.mass)/(pow(r,2)))* -dir
		return FGravity

func Max_Vector():
	var tempG = Vector2.ZERO
	for vector in gvectors:
		if sqrt(pow(gvectors[vector].x,2)+pow(gvectors[vector].y,2)) > sqrt(pow(tempG.x,2)+pow(tempG.y,2)):
			tempG = gvectors[vector]
			orbiting_planet = vector
	FGravity = tempG
	

func Set_Gravity_Vector(delta):
	gvectors.clear()
	for i in Planets.size():
		gvectors[Planets[i]] = Calc_grav(Planets[i])
		Max_Vector()

	moonRB.linear_velocity += FGravity * delta



func moon_set(mass):
	moonRB.mass = mass
	

