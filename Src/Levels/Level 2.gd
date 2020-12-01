extends Node2D

var level_flag = 2
onready var Luna = $Luna
#onready var Planet = get_node("Barren Planet")#temp
onready var trajectory = get_node("Luna/Line2D")
onready var planetScript = preload("res://Src/Levels/Planet.gd")
onready var asteroid = preload("res://Src/Levels/Asteroid.tscn")
onready var gm = get_tree().get_root().get_node("/root/GameManager")
onready var tutorial = gm.get_node("gameViewport/Viewport/HUD/Tutorial")
onready var minimap = gm.get_node("Minimap")
onready var minimap_cam = minimap.get_node("Viewport/Camera")
onready var minimap_pos = Luna.get_node("RigidBody2D/MinimapPosition")
onready var cam_tween = Luna.get_node("RigidBody2D/Camera2D/Zoom")
var comet = preload("res://Src/Props/Comet.tscn")
var comet_amount = 0
var blinkeystar = preload("res://Src/Props/BlinkeyStar.tscn")
var blinkierstar = preload("res://Src/Props/BlinkierStar.tscn")
var screenSize = get_viewport_rect()
var Planets = []
var Wormholes = []
var flag = true as bool

func _ready():
	if Global.new_game_flag == true:
		tutorial.show()
	if minimap.visible == false:
		minimap.show()
		gm.get_node("BG").show()
	#Luna.planet_set(Planet)
	#Planet.lunaRB_set($Luna/RigidBody2D)
	Pop_Planets()
	Pop_Wormholes()
	Pop_Asteroids()
	check_for_comets()
	_make_stars()
	

func Pop_Wormholes():
	for wormhole in $Wormholes.get_children():
		if wormhole.ID == "WormholeEnter" || wormhole.ID == "WormholeExit":
			Wormholes.insert(Wormholes.size(),wormhole)
			print(Wormholes)
	Luna.Wormholes_set(Wormholes)
	
func Pop_Planets():
	for planet in get_children():
		if(planet.get_class() == "Node2D"):
			if(planet.get_script() == planetScript):
				var new_planets = Planets
				new_planets.insert(Planets.size(),planet)
	Luna.Planets_set(Planets)
	Pop_moons()
	
func Pop_moons():
	for planet in Planets:
#		if planet.get_node("Moon") != null:
#			var moon = planet.get_node("Moon")
#
#			moon.Planets_set(Planets)
		for moon in planet.get_children():
			if moon.get_class() == "Node2D":
				if moon.ID == "moon":
					moon.Planets_set(Planets)
					
func Pop_Asteroids():
	for textrect in $"Asteroid Field".get_children():
		var ast_count = 500
		for ast in ast_count:
			ast = asteroid.instance()
			textrect.add_child(ast)
			ast.position.x = rand_range(textrect.rect_global_position.x,textrect.rect_size.x) 
			ast.position.y = rand_range(textrect.rect_global_position.y,textrect.rect_size.y) 
			#print(ast)

func _process(_delta):
	#luna_controls(lunaRB,planetGrav)
	check_for_comets()
	align_minimap()

func align_minimap():
	if flag == true:
		minimap_cam.global_transform.origin = minimap_pos.global_transform.origin

func _make_comets():
	comet_amount = 100
	for _i in range(comet_amount):
		var new_comet = comet.instance()
		
		new_comet.position.x = rand_range(min(screenSize.position.x,screenSize.position.x), max(screenSize.position.x,screenSize.position.x+1024))
		new_comet.position.y =rand_range(min(screenSize.position.y,screenSize.position.y), max(screenSize.position.y,screenSize.position.y+600))
		
		var comet_var = randf()
		randomize()
		if comet_var < 0.7:
			$Background/YSort.add_child(new_comet)
		elif comet_var >= 0.3:
			$Background/ForergroundStars.add_child(new_comet)
	
func check_for_comets():
	if comet_amount == 0:
		_make_comets()

func _make_stars():
	for _i in range(1000):
		var star_var = randf()
		randomize()
		var new_star
		if star_var < 0.5:
			new_star = blinkeystar.instance()
		elif star_var >= 0.5:
			new_star = blinkierstar.instance()
			
		
		#new_star.position.x = rand_range(Luna.lunaRB_get().get_position().x-500, Luna.lunaRB_get().get_position().x+500)
		#new_star.position.y = rand_range(Luna.lunaRB_get().get_position().y-500, Luna.lunaRB_get().get_position().y+500)
		new_star.position.x = rand_range(min(screenSize.position.x,screenSize.position.x), max(screenSize.position.x,screenSize.position.x+1024))
		new_star.position.y =rand_range(min(screenSize.position.y,screenSize.position.y), max(screenSize.position.y,screenSize.position.y+600))
		
		if star_var < 0.4:
			$Background/YSort.add_child(new_star)
		elif star_var >= 0.6:
			$Background/ForergroundStars.add_child(new_star)

