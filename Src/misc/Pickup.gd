extends KinematicBody2D

var pick_up = false as bool
var Acceleration = 800
var Max_Speed = 600
var velocity = Vector2.ZERO
onready var player = get_parent().get_parent().get_node("Luna/RigidBody2D")
onready var ysort = get_parent().get_child_count()


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.max_pickups = ysort


func _process(delta):
	if player:
		if pick_up == true:
			var direction = global_position.direction_to(player.global_position)
			velocity = velocity.move_toward(direction * Max_Speed, Acceleration * delta)	
			var distance = global_position.distance_to(player.global_position)
			if distance < 70:
				pick_up = false
				Events.emit_signal("play_sound", "Pickup")
				Global.got_pickups += 1
				queue_free()
			velocity = move_and_slide(velocity)

func _on_PickupArea_body_entered(body):
	if body.is_in_group("Luna"):
		pick_up = true
		Events.emit_signal("pickup")

