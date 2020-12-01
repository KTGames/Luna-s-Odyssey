extends Node2D

class_name Planets

onready var rb = $RigidBody2D
onready var luna = get_parent().get_node("Luna")
var Mass setget Mass_set, Mass_get
var planetRad setget Rad_set, Rad_get
var dir 
var orbit_complete
var starting_angle
var ID = "Planet"
var angle = 0
var new_angle
var angles = []
var luna_orbiting



func _ready():
	Mass_set(rb.get_node("CollisionShape2D").shape.radius*25)
	Rad_set($RigidBody2D/CollisionShape2D.shape.radius)
	orbit_complete = false
	luna_orbiting = false

func _physics_process(delta):
	if luna_orbiting == false:
		angles.clear()
	if luna && luna_orbiting == true && orbit_complete == false:
		new_angle = stepify(rad2deg(get_angle_to(luna.lunaRB.global_position)),1)
		
		if angle != new_angle:
			if !angles.has(new_angle):
				angle = new_angle
				angles.insert(angles.size(),new_angle)
			else:
				orbit_complete = true
				angles.clear()

func Rad_set(rad):
	planetRad = rad
	
func Rad_get():
	return planetRad

func Mass_set(mass):
	rb.mass = mass

func Mass_get():
	Mass = rb.mass
	return Mass
