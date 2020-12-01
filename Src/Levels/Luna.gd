extends Node2D

var floating_text = preload("res://Src/misc/FloatingText.tscn")
var add_score = preload("res://Src/misc/add_score.tscn")

onready var lunaRB = $RigidBody2D
onready var ani = lunaRB.get_node("AnimatedSprite")
#var planet setget planet_set
var Planets setget Planets_set
var Wormholes setget Wormholes_set
var luna setget luna_set, luna_get
onready var gm = get_tree().get_root().get_node("/root/GameManager")
onready var BrokenLuna = preload("res://Src/Levels/Player_Exploads.tscn")
#onready var popup = gm.get_node("gameViewport/Viewport/HUD/PopupPanel")
onready var camera = get_node("RigidBody2D/Camera2D")
onready var score_label = get_node("RigidBody2D/CanvasLayer/ScoreLabel")
export var FGravity: Vector2
var gvectors = {}
export var G = .3
var orbiting_planet
var new_planet
var starting_orbit
var inWormhole
var exploaded
var potential_energy
var dist_multi = []
var temp_points = 0
var points
var angles = []
var round_angle = 0
var complete_orbit
var recorded_data = [] #the array we update when moving, check when recording
var is_rewinding = false # we'll use this to disable this object when true. so we can add recorded to it
var rewind_length = (60 * 8) # 8 seconds at 60 fps
var shield = false
var powerup_flag = false as bool
var zoomin = true as bool
var texture_rewinding_pressed = false

func _ready():
	Events.connect_signal("pickup", self, "increase_potential")
	luna_set(lunaRB.get_node("CollisionShape2D").shape.radius*25)
	connect("_on_RigidBody2D_body_entered",self,"Collision")
	$RigidBody2D/CanvasLayer/Redirect.luna_set(self)
	$RigidBody2D/CanvasLayer/Shield.luna_set(self)
	$RigidBody2D/CanvasLayer/Rewind.luna_set(self)
	if get_parent().level_flag == 1:
		potential_energy = 500
	else:
		potential_energy = 0
	points = 0
	exploaded = false
	inWormhole = false


	
func _physics_process(delta):
	if lunaRB:
		luna_control(delta)
		handle_rewind_function()
		if inWormhole:
				lunaRB.linear_velocity -= lunaRB.linear_velocity/100
		if(!is_rewinding):
			Set_Gravity_Vector(delta)
			update_energy_bar()
			point_counter()
			powerup_flag = false
		else:
			powerup_flag = true
			pass


func handle_rewind_function():
	var ani_number = ani.get_index()
	if is_rewinding == true:
#		potential_energy = 
		lunaRB.global_position
		if(recorded_data.size() > 0):
			var current_frame = recorded_data[0]
			
			#Set values to the first frame of the array
			if(current_frame != null):
				ani.animation = current_frame[0]
				lunaRB.global_position = current_frame[1]
		else:
			is_rewinding = false
			#potential_energy -= 300
			planets_reset()
		#Remove the first frame
		recorded_data.pop_front()
		
#	elif(Input.is_action_just_released("ui_focus_prev") && is_rewinding == true):
#		potential_energy = 0
		
	else: # Recording
		recorded_data.push_front([ani.animation,lunaRB.global_position])
		if(recorded_data.size() > rewind_length): # our record is longer than 10 secs, removes
			recorded_data.pop_back()

func Wormholes_set(new_Wormholes):
	if Wormholes:
		Wormholes.clear()
	Wormholes = new_Wormholes

func Planets_set(new_Planets):
	if Planets:
		Planets.clear()
	Planets = new_Planets
#	for i in Planets:
#		print(i)

func point_counter():
	if new_planet:
		if orbiting_planet == new_planet:
			if orbiting_planet.ID == "Planet":
				if !complete_orbit:
					var text = floating_text.instance()
					if !orbiting_planet.orbit_complete:
						var distance = lunaRB.global_position.distance_to(orbiting_planet.global_position)-orbiting_planet.Rad_get()
						if distance < 50:
							#print("multiplier x50")
							temp_points += 50
							if potential_energy < 495:
								potential_energy += 5
							else: 
								potential_energy = 500
						elif distance < 100:
							temp_points+= 25
							if potential_energy < 498:
								potential_energy += 2
							else: 
								potential_energy = 500
							#print("multiplier x25")
						elif distance < 150:
							temp_points+= 10
							if potential_energy < 499:
								potential_energy += 1
							else: 
								potential_energy = 500
							#print("multiplier x10")
						elif distance < 200:
								#print("multiplier x5")
								temp_points+= 5
								if potential_energy < 499.5:
									potential_energy += .5
								else: 
									potential_energy = 500
						else:
							temp_points += 1
							if potential_energy < 499.9:
								potential_energy += .1
							else: 
								potential_energy = 500
						text.amount = temp_points
						text.pop = "temp"
						lunaRB.add_child(text)
					else:
						if temp_points > 0:
							points += temp_points
							Global.points += points
							text = floating_text.instance()
							text.type = "Add"
							text.amount = points
							text.pop = "points"
							lunaRB.add_child(text)
							var score = add_score.instance()
							score.amount = points
							score_label.add_child(score)
							temp_points = 0
							points = 0
							complete_orbit = true
				
		else:
			if orbiting_planet:
				if orbiting_planet.ID == "Planet":
					orbiting_planet.luna_orbiting = false
			orbiting_planet = new_planet
			if orbiting_planet.ID == "Planet":
				orbiting_planet.luna_orbiting = true
			temp_points = 0
			complete_orbit = false
			
		
func planets_reset():
	for planet in Planets:
		planet.luna_orbiting = false
		planet.angles.clear()
	if new_planet.ID == "Planet":
		new_planet.luna_orbiting = true
		
func Calc_grav(body):
	#F = G * (m1 * m2)/r^2
	var mass = body.Mass_get()
	var r = lunaRB.global_position.distance_to(body.global_position)
	var dir = lunaRB.global_position-body.global_position
	var FGrav
	if r == 0: 
		FGrav = Vector2.ZERO
	else:
		FGrav = (G * (mass * lunaRB.mass)/(pow(r,2)))* -dir
	if new_planet:
		if body.ID == "WormholeExit":
			FGrav *= -1
			#print(FGrav)
	return FGrav

func Max_Vector():
	var tempG = Vector2.ZERO
	for vector in gvectors:
		if sqrt(pow(abs(gvectors[vector].x),2)+pow(abs(gvectors[vector].y),2)) > sqrt(pow(abs(tempG.x),2)+pow((tempG.y),2)):
			tempG = gvectors[vector]
			new_planet = vector
			if new_planet.ID == "WormholeEnter":
				inWormhole = true
			else:
				inWormhole = false
	FGravity = tempG
	

func Set_Gravity_Vector(delta):
	gvectors.clear()
	for i in Planets.size():
		gvectors[Planets[i]] = Calc_grav(Planets[i])
		Max_Vector()
	for i in Wormholes.size():
		gvectors[Wormholes[i]] = Calc_grav(Wormholes[i])
		Max_Vector()
	if new_planet.ID == "WormholeEnter":
		inWormhole = true
	else:
		inWormhole = false
	lunaRB.linear_velocity += FGravity * delta

func update_energy_bar():
	$"RigidBody2D/CanvasLayer/Energy Bar/TextureProgress".value = potential_energy*2

func redirect_powerup():
	#lunaRB.add_central_force(get_global_mouse_position())
	if $RigidBody2D/redirectui.can_redirect == true:
		lunaRB.linear_velocity = get_global_mouse_position() -lunaRB.global_position  
		$RigidBody2D/redirectui.visible = false
		$RigidBody2D/redirectui.can_redirect = false
		#potential_energy -= 100
		planets_reset()
	
func shield_powerup():
	#potential_energy -= 200
	if shield == false:
		shield = true
		$RigidBody2D/AnimatedSprite/Shield.visible = true
	

func luna_control(delta):
	if Input.is_action_pressed("accelerate"):
		if potential_energy > 0:
			#lunaRB.add_force(Vector2.ZERO,Vector2((lunaRB.linear_velocity.x*25),(lunaRB.linear_velocity.y*25)))
			lunaRB.linear_velocity += lunaRB.linear_velocity/50
			potential_energy -= 1
			camera.shake(delta+1, 8, 6)
	else:
		lunaRB.applied_force = Vector2.ZERO
	if Input.is_action_pressed("brake"):
		#lunaRB.add_force(Vector2.ZERO,Vector2((-lunaRB.linear_velocity.x*50),-lunaRB.linear_velocity.y*50))
		lunaRB.linear_velocity -= lunaRB.linear_velocity/50
#		if potential_energy < 50:
#			potential_energy += 1
	if Input.is_action_just_pressed("Click") && powerup_flag == false && zoomin == false:
		if potential_energy > 99:
			redirect_powerup()
			#update_energy_bar()
			potential_energy -= 99
	if Input.is_action_just_pressed("ADD_FUEL"):
		potential_energy = 250
	if Input.is_action_just_pressed("Shield"):
		if potential_energy > 199:
			shield_powerup()
			potential_energy -= 199
	if(Input.is_action_just_pressed("ui_focus_prev") && potential_energy > 299): # ITS REWIND TIME
		is_rewinding = true
		planets_reset()
	if(Input.is_action_just_released("ui_focus_prev")&& is_rewinding == true):
		is_rewinding = false
		planets_reset()
		potential_energy -= 300
	if ($RigidBody2D/CanvasLayer/Rewind.pressed == true && potential_energy > 299):
		is_rewinding= true
		planets_reset()
		texture_rewinding_pressed = true
	if(!$RigidBody2D/CanvasLayer/Rewind.pressed && texture_rewinding_pressed == true):
		is_rewinding = false
		planets_reset()
		potential_energy -= 300
		texture_rewinding_pressed = false
	if Input.is_action_just_pressed("Redirect"):
		if potential_energy > 99:
			$RigidBody2D/redirectui.visible = true


#func planet_set(newPlanet):
#	planet = newPlanet
	

func luna_set(mass):
	lunaRB.mass = mass
	lunaRB.linear_velocity = Vector2(250,0)
	print("luna set")
	$Line2D.luna_set(self)
	
func luna_get():
	return lunaRB

func increase_potential():
	if potential_energy > 250:
		potential_energy = 500
	else:
		potential_energy += 250

func Collision():
	if !exploaded:
		var BL = BrokenLuna.instance()
		BL.planets_set(Planets)
		BL.luna_set(self)
#		lunaRB.set_mode(1)
#		exploaded = true


func _on_RigidBody2D_body_entered(body):
	if shield && body.get_parent().ID == "moon":
		shield = false
		$RigidBody2D/AnimatedSprite/Shield.visible = false
	elif shield && body.get_parent().ID == "asteroid":
		shield = false
		$RigidBody2D/AnimatedSprite/Shield.visible = false
	else:
		Events.emit_signal("play_sound", "Explosion")
		Events.emit_signal("dead")
		set_process_input(false)
		set_process_unhandled_input(false)
		get_parent().flag = false
		Collision()

func _on_Zoom_tween_all_completed():
	camera.current = true
	zoomin = false



