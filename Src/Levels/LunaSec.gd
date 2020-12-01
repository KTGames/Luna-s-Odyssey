extends RigidBody2D

var planets setget planets_set
export var FGravity: Vector2
export var G = .3
var gvectors = {}
var orbiting_planet

func _physics_process(delta):
	if planets != null:

		Set_Gravity_Vector(delta)

func planets_set(Lplanets):
	planets = Lplanets
	


func Calc_grav(planet):
	#F = G * (m1 * m2)/r^2
		var r = global_position.distance_to(planet.global_position)
		var dir = global_position-planet.global_position
		FGravity = (G * (planet.Mass_get() * mass)/(pow(r,2)))* -dir
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
	for i in planets.size():
		gvectors[planets[i]] = Calc_grav(planets[i])
		Max_Vector()

	linear_velocity += FGravity * delta
