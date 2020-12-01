extends Control

var first_pass = false as bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "default" and first_pass == false:
		$AnimationPlayer.play("loop")
		$AnimationPlayer.seek(0.0)
		$Timer.start()
		first_pass = true

func _on_Timer_timeout():
	$AnimationPlayer.set_speed_scale(1.0)
	$AnimationPlayer.play("default (copy)")
	$AnimationPlayer.seek(0.0)
	
