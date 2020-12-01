extends Node2D

onready var gm = get_parent()
enum MusicState{Menu, Game}

func _ready():
	# Event Hooks
	Events.connect_signal("play_sound", self, "_playSound")
	Events.connect_signal("switch_music", self, "_switchMusic")
	
	# Init Start Music
	_switchMusic(Global.userConfig.music) 

###############################################################################
# Callbacks
###############################################################################

# Event Hook: Play or stop music
func _switchMusic(val: bool):
	if val:
		AudioServer.set_bus_mute(2, false)
	else:
		AudioServer.set_bus_mute(2, true)

func all_stop():
	$MenuMusic.stop()
	$GameMusic.stop()
	$Intro.stop()

func switchTo(to):
	all_stop()
	
	match to:
		MusicState.Menu:
			$MenuMusic.play()
		MusicState.Game:
			if Global.last_level == 0:
				$Intro.play()
			else:
				$GameMusic.play()
		_:
			print("State not found")


func _process(_delta):
	pass
	
# Event Hook: Play a sound
func _playSound(sound: String, _volume : float = 1.0, _pos : Vector2 = Vector2(0, 0)):
	if Global.userConfig.sound:
		match sound:
			"menu_click":
				$MenuSettingConfirm.play()
			"play_click":
				$MenuPlayConfirm.play()
			"change_setting":
				$MenuChangeSetting.play()
			"back_click":
				$MenuCancel.play()
			"Explosion":
				$Explosion.play()
			"Pickup":
				$Pickup.play()
			_:
				print("error: sound not found - name: " + str(sound))
