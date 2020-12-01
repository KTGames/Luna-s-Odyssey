extends Control

onready var grid = $Panel1/GridContainer
onready var ctrl = grid.get_node("Panel/Control")
onready var space = grid.get_node("Panel2/Space")
var pressed_ctrl_flag = false as bool
var pressed_space_flag = false as bool
var panel1 = false as bool
var panel2 = false as bool
var panel3 = false as bool
var panel4 = false as bool
var panel5 = false as bool
var panel6 = false as bool
var panel7 = false as bool

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel1.show()
	ctrl.play()
	space.play()

func _input(_event):
	if Input.is_action_pressed("accelerate"):
		pressed_space_flag = true
	if Input.is_action_pressed("brake"):
		pressed_ctrl_flag = true

func _process(_delta):
	if pressed_ctrl_flag == true and pressed_space_flag == true and panel1 == false:
		$AnimationPlayer.play("fade_out_panel1")
		panel1 = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out_panel1":
		$Panel1.hide()
		$Timer.start()
		$Panel2.show()
	elif anim_name == "fade_out_panel2":
		$Panel2.hide()
		$Timer.start()
		$Panel3.show()
		panel2 = true
	elif anim_name == "fade_out_panel3":
		$Panel3.hide()
		$Timer.start()
		$Panel4.show()
		panel3 = true
	elif anim_name == "fade_out_panel4":
		$Panel4.hide()
		$Timer.start()
		$Panel5.show()
		panel4 = true
	elif anim_name == "fade_out_panel5":
		$Panel5.hide()
		$Timer.start()
		$Panel6.show()
		panel5 = true
	elif anim_name == "fade_out_panel6":
		$Panel6.hide()
		$Timer.start()
		$Panel7.show()
		panel6 = true
	elif anim_name == "fade_out_panel7":
		$Panel7.hide()
		panel7 = true
		$AnimationPlayer.stop()

func _on_Timer_timeout():
	if panel2 == false:
		$AnimationPlayer.play("fade_out_panel2")
	elif panel3 == false:
		$AnimationPlayer.play("fade_out_panel3")
	elif panel4 == false:
		$AnimationPlayer.play("fade_out_panel4")
	elif panel5 == false:
		$AnimationPlayer.play("fade_out_panel5")
	elif panel6 == false:
		$AnimationPlayer.play("fade_out_panel6")
	elif panel7 == false:
		$AnimationPlayer.play("fade_out_panel7")
