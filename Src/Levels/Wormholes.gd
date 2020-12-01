extends Node2D

signal cutscene_shit

var Mass setget Mass_set, Mass_get
var whRad setget whRad_set, whRad_get
var whExit 
export var exitID = 1
var ID = "WormholeEnter"
onready var level = get_parent().get_parent()


func _ready():
	Mass_set(1000)
	whRad_set($CollisionShape2D.shape.radius)
	#whExit = get_parent().get_node("WormholeExit2")
	
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

func _on_WormholeEnter_body_entered(body):
	if body.is_in_group("Luna"):
		var level = body.get_parent().get_parent()
		body.get_parent().get_node("Line2D").hide()
		level.flag = false
		if level.level_flag == 1:
			if exitID == 1:
				whExit = get_parent().get_node("WormholeExit")
				body.linear_velocity = Vector2(100,0)
				print("i'ma go over here")
			elif exitID == 2:
				print("something else")
				whExit = get_parent().get_node("WormholeExit2")
				body.linear_velocity = Vector2(0,-300)
		elif level.level_flag == 3:
			if exitID == 1:
				whExit = get_parent().get_node("WormholeExit")
				body.linear_velocity = Vector2(0,-300)
		elif level.level_flag == 4:
			if exitID == 1:
				whExit = get_parent().get_node("WormholeExit")
				body.linear_velocity = Vector2(300,0)
		elif level.level_flag == 5:
			if exitID == 1:
				whExit = get_parent().get_node("WormholeExit")
				body.linear_velocity = Vector2(0,-300)
			elif exitID == 2:
				whExit = get_parent().get_node("WormholeExit2")
				body.linear_velocity = Vector2(0,-300)
		elif level.level_flag == 6:
			if exitID == 1:
				whExit = get_parent().get_node("WormholeExit")
				body.linear_velocity = Vector2(0,-300)
		elif level.level_flag == 7:
			if exitID == 1:
				whExit = get_parent().get_node("WormholeExit")
				body.linear_velocity = Vector2(0,300)
		elif level.level_flag == 8:
			if exitID == 1:
				whExit = get_parent().get_node("WormholeExit")
				body.linear_velocity = Vector2(200,-300)
		elif level.level_flag == 9:
			if exitID == 1:
				whExit = get_parent().get_node("WormholeExit")
				body.linear_velocity = Vector2(0,-300)
				exitID = 2
			elif exitID == 2:
				whExit = get_parent().get_node("WormholeExit2")
				body.linear_velocity = Vector2(0,300)
		print(body.global_position)#FOR SOME REASON THIS NEEDS TO BE HERE IUNNO MAN
		body.global_position = whExit.get_node("CollisionShape2D").global_position
	elif body.is_in_group("cutscene"):
		body.queue_free()
		emit_signal("cutscene_shit")

func _on_WormholeExit_body_entered(body):
	if body.is_in_group("Luna"):
		print('zoom')
		var level = body.get_parent().get_parent()
		body.get_parent().get_node("Line2D").show()
		level.flag = true
		body.get_parent().inWormhole = false


func _on_WormholeExit2_body_entered(body):
	if body.is_in_group("Luna"):
		print("eject")
		var level = body.get_parent().get_parent()
		body.get_parent().get_node("Line2D").show()
		level.flag = true
		body.get_parent().inWormhole = false

