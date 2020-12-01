extends TextureButton
var luna setget luna_set



func _process(delta):
	if luna.potential_energy < 199:
		disabled = true
		$TextureRect.visible = false
	else:
		disabled = false
		$TextureRect.visible = true



func luna_set(l):
	luna = l


func _on_Shield_button_up():
	luna.shield_powerup()
