extends Node2D
var ID = "asteroid"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var rand = randi()%4
	if rand == 0:
		rand = ""
	var ast = str("res://Assets/Textures/Asteroids/Asteroid",rand,".png")
	get_node("Sprite").texture = load(ast)


