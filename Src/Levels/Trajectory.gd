extends Line2D

onready var luna setget luna_set
onready var planet setget planet_set
var max_points = 25


func ready():
	self.show()

func luna_set(rb):
	luna = rb
	
func planet_set(pg):
	planet = pg
	print("Ping")



func _physics_process(delta):
	if luna:
		update_trajectory(delta)



func update_trajectory(delta):
	self.clear_points()
	if luna.lunaRB:
		var pos = luna.lunaRB.position
		var vel = luna.lunaRB.linear_velocity
		var gforce = luna.FGravity
		for i in max_points:
			self.add_point(pos)
			vel += gforce * delta
			pos += vel * delta



	



