extends Label

func _ready():
	Global.points = 0

func _process(_delta):
	if Global.points == 0:
		text = " "
	elif Global.points >= 1:
		text = str(Global.points)
