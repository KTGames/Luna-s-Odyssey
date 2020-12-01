extends Node2D

onready var gm = get_tree().get_root().get_node("GameManager")
onready var planet = $"YSort/Actors/Barren Planet"
onready var moon = $"YSort/Actors/Barren Planet/Moon"
onready var wormhole = $YSort/Actors/Wormholes/WormholeEnter
onready var wormhole_anim = $YSort/Actors/Wormholes/Wormhole/AnimationPlayer
onready var yeet_anim = $YSort/Actors/Wormholes/Sprite/AnimationPlayer
onready var main_anim = $AnimationPlayer
onready var warp = $WarpScene
onready var more_warp = $WarpScene/CanvasLayer/YSort
onready var warp_anim = $WarpScene/AnimationPlayer
var Wormholes = []
var Planets = []


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(false)
	Events.emit_signal("no_mini_map")
	Wormholes.append(wormhole)
	Planets.append(planet)
	moon.Planets_set(Planets)
	moon.Wormholes_set(Wormholes)
	wormhole_anim.play_backwards("New Anim")
	main_anim.play("default")
	main_anim.seek(0.0)


func _on_AnimationPlayer_animation_finished(anim_name):
	warp_anim.play("default")
	warp_anim.seek(0.0)

func load_da_game():
	gm.unloadLevel()
	gm.loadLevel(1)
