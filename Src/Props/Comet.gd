extends AnimatedSprite

var rand : float = rand_range(1.2, 5) 
onready var level = get_parent().get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	stop()
	$Timer.wait_time = rand
	#yield(get_tree().create_timer(0.2), "timeout")
	$Timer.start()


func _on_Timer_timeout():
	play()


func _on_Comet_animation_finished():
	level.comet_amount -= 1
	queue_free()
	#print(position)


