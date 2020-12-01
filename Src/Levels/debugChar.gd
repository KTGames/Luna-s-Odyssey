extends Position2D

onready var luna = get_parent()


func _input(event):
	if Input.is_action_pressed("ui_left"):
		position.x -= 100
	if Input.is_action_pressed("ui_up"):
		position.y -= 100
	if Input.is_action_pressed("ui_right"):
		position.x += 100
	if Input.is_action_pressed("ui_down"):
		position.y += 100
	if Input.is_action_pressed("ui_focus_next"):
		luna.get_node("RigidBody2D/Camera2D").current = true
		$Camera2D.current = false
		

