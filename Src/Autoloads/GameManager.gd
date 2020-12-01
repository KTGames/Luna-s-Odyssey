extends Control

var black = ColorN("black",1)
var level = null
var state = Types.GameStates.Menu
var new_res
var last_level
var level_loaded = false as bool

onready var menu = $menuViewport/Viewport/Menu
onready var audio = $AudioPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	$Minimap/Viewport.world_2d = $gameViewport/Viewport.world_2d
	$anim.play("fade_in")
	VisualServer.set_default_clear_color(black)
	#Global.debugLabel = $Debug

	# Event Hooks
	Events.connect_signal("switch_sound", self, "_switchSound")
	Events.connect_signal("switch_music", self, "_switchMusic")
	Events.connect_signal("switch_fullscreen", self, "_switchFullscreen")
	Events.connect_signal("new_game", self, "_newGame")
	Events.connect_signal("continue_game", self, "_continueGame")
	Events.connect_signal("menu_back", self, "_backToMenu")

	switchTo(Types.GameStates.Menu)
	
func _input(_event):
	if state == Types.GameStates.Menu and Input.is_action_pressed("ui_cancel"):
		menu._back()
	if state == Types.GameStates.Game and Input.is_action_pressed("ui_cancel"):
		#_backToMenu()
		#$anim.play("fade_in")
		pass

# State Transition Function
func switchTo(to):
	if to == Types.GameStates.Menu:
		$gameViewport.hide()
		$menuViewport.show()
		menu.show()
		if $AudioPlayer/MenuMusic.is_playing() == false:
			audio.switchTo(audio.MusicState.Menu)
	elif to == Types.GameStates.Game:
		$gameViewport.show()
		$menuViewport.hide()
		menu.hide()
		audio.switchTo(audio.MusicState.Game)
	state = to


func loadLevel(number = 0):
	print(Global.levels[number])
	level = load(Global.levels[number]).instance()
	if $anim.is_playing() == true:
		yield($anim, "animation_finished")
	$gameViewport/Viewport/LevelHolder.add_child(level)
	level_loaded = true
	last_level = number
	Global.last_level = last_level
	switchTo(Types.GameStates.Game)


func unloadLevel():
	$gameViewport/Viewport/LevelHolder.remove_child(level)
	level.queue_free()
	level = null
	level_loaded = false
###############################################################################
# Callbacks
###############################################################################

# Event Hook: Back from Game to Menu
func _backToMenu():
	unloadLevel()
	switchTo(Types.GameStates.Menu)
	$anim.play("fade_in")

# Event Hook: New Game
func _newGame():
	$anim.play("fade_out")
	loadLevel(0)

func _continueGame():
	switchTo(Types.GameStates.Menu)
	$menuViewport/Viewport/Menu.switchTo($menuViewport/Viewport/Menu.MenuState.Levels)
	
# Event Hook: Update user config for sound
func _switchSound(value):
	Global.userConfig.sound = value
	Global.saveConfig()

# Event Hook: Update user config for music
func _switchMusic(value):
	Global.userConfig.music = value
	Global.saveConfig()

# Event Hook: Switch to fullscreen mode and update user config
func _switchFullscreen(value):
	Global.setFullscreen(value)


func _on_anim_animation_started(anim_name):
	if anim_name == "fade_out":
		for buttons in get_tree().get_nodes_in_group("level_button"):
			buttons.disabled = true
	elif anim_name == "fade_in":
		for buttons in get_tree().get_nodes_in_group("level_button"):
			menu.if_unlocked()
