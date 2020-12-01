extends TextureButton
var luna setget luna_set


func luna_set(l):
	luna = l

func _process(delta):
	if luna.potential_energy < 299:
		disabled = true
		$TextureRect.visible = false
	else:
		disabled = false
		$TextureRect.visible = true


func _on_Rewind_pressed():
	luna.is_rewinding = true
