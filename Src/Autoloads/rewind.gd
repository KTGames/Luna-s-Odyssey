extends Node

var is_rewinding = false
var rewind_length = (60 * 10)
var count = 0 #used to determine where we are in the array
var DATA = []
var rewind_objects

func _ready():
	rewind_objects = get_tree().get_nodes_in_group("rewind")
	for mem in rewind_objects:
		DATA.push_back([mem.name])
		
func handle_rewind_objects():
	if(Input.is_action_pressed("ui_focus_prev")):
		is_rewinding = true
		for mem in rewind_objects:
			var moonRB = mem.get_node("RigidBody2D")
			print(moonRB.global_position)
			var data = DATA[count]
			if(data.size() > 1):
				var current_frame = data[0]
				var ani = moonRB.get_node("CollisionShape2D/AnimatedSprite")
				
				ani.animation = current_frame[0]
				moonRB.global_position = current_frame[1]
				moonRB.linear_velocity = current_frame[2]
				
				data.pop_front()
				count+=1
		count = 0
	else:
		is_rewinding = false
		for mem in rewind_objects:
			var data = DATA[count]
			var moonRB = mem.get_node("RigidBody2D")
			var ani = moonRB.get_node("CollisionShape2D/AnimatedSprite")
			data.push_front([ani.animation, moonRB.global_position, moonRB.linear_velocity])
			count += 1
			if(data.size() > rewind_length):
				data.pop_back()
		count = 0
		pass
			
func _physics_process(_delta):
	handle_rewind_objects()

