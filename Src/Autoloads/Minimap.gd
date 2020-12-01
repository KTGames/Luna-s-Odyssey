extends ViewportContainer

onready var bg = get_parent().get_node("BG")

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect_signal("no_mini_map", self, "_hide")
	Events.connect_signal("dead", self, "_hide")
	Events.connect_signal("end_level", self, "_hide")

func _hide():
	bg.hide()
	hide()
