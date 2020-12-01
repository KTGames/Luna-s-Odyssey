extends AnimatedSprite


var rand : float = rand_range(0,10)


# Called when the node enters the scene tree for the first time.
func _ready():
	stop()
	$Timer.wait_time = rand
	$Timer.start()

func _on_Timer_timeout():
	play()
	


func _on_BlinkeyStar_animation_finished():
	self.playing = false
	self.frame = 0
	$Timer.start()
