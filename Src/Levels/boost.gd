extends TextureButton
var luna setget luna_set



func _ready():
	pass
	
func luna_set(l):
	luna = l

func _process(delta):
	if luna.potential_energy < 99: 
		disabled = true
		$TextureRect.visible = false
		luna.get_node("RigidBody2D/redirectui").can_redirect = false

	else:
		disabled = false
		$TextureRect.visible = true


func _on_TextureButton_button_up():
	if disabled == false:
		luna.get_node("RigidBody2D/redirectui").visible = true
	
