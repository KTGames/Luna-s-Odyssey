extends Popup

enum MenuState {GameOver, Pause} 
enum ButtonState {Back, Settings, Other, Highscores}

onready var gm = get_tree().get_root().get_node("/root/GameManager")
onready var label = $TextureRect/VBoxContainer/GameOver
onready var menu = $TextureRect/VBoxContainer/Menu
onready var settings = $TextureRect/VBoxContainer/Settings
onready var other = $TextureRect/VBoxContainer/Other
onready var highscores = $TextureRect/VBoxContainer/Highscores
onready var settings_buttons = $TextureRect/VBoxContainer/Settings/MarginContainer/VBoxContainer
onready var score_labels = $TextureRect/VBoxContainer/Highscores/MarginContainer/HBoxContainer/VBoxContainer
var menu_flag = true as bool
var back_flag = true as bool


func switchTo(to):
	hideAllMenuScenes()

	match to:
		MenuState.GameOver:
			label.bbcode_text = "[wave amp=50 freq=2][center]Game Over[/center][/wave]"
			menu.show()
			menu_flag = false
		MenuState.Pause:
			label.bbcode_text = "[wave amp=50 freq=2][center]Pause[/center][/wave]"
			menu.show()
			menu_flag = true
		_:
			print("Invalid menu state")
			
func switchButton(to):
	hideAllMenuScenes()
	
	match to:
		ButtonState.Back:
			menu.show()
			back_flag = true
		ButtonState.Settings:
			settings.show()
			back_flag = false
		ButtonState.Other:
			other.show()
			back_flag = false
		ButtonState.Highscores:
			highscores.show()
			back_flag = false
		_:
			return


func hideAllMenuScenes():
	# Add menu scenes here
	menu.hide()
	settings.hide()
	other.hide()
	highscores.hide()
	menu_flag = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect_signal("switch_sound", self, "_switchSound")
	Events.connect_signal("switch_music", self, "_switchMusic")
	Events.connect_signal("switch_fullscreen", self, "_switchFullscreen")
	updateSettings()
	update_highscores()
	
func _process(_delta):
	update_highscores()

func _input(event):
	if gm.level_loaded == true:
		if menu_flag == true:
			if event.is_action_pressed("ui_cancel") and gm.level_loaded == true:
				switchTo(MenuState.Pause)
				var new_pause_state = not get_tree().paused
				get_tree().paused = new_pause_state
				visible = new_pause_state

# Event Hook
func _switchSound(_val):
	updateSettings()

# Event Hook
func _switchMusic(_val):
	updateSettings()

# Event Hook
func _switchFullscreen(_val):
	updateSettings()


func _on_Button_button_up():
	if Global.new_game_flag == true:
		Global.new_game_flag = false
	var level_flag = gm.last_level
	gm.unloadLevel()
	gm.loadLevel(level_flag)
	get_tree().paused = false
	menu_flag = true
	hide()


func _on_Button2_button_up():
	menu_flag = true
	hide()
	get_tree().paused = false
	gm.get_node("anim").play("fade_in")
	gm._backToMenu()
	gm.switchTo(Types.GameStates.Menu)

func _on_Button3_button_up():
	get_tree().quit()

func updateSettings():
	if Global.userConfig.sound:
		settings_buttons.get_node("Sound/Text").bbcode_text = "[center]Sound: On[/center]"
	else:
		settings_buttons.get_node("Sound/Text").bbcode_text = "[center]Sound: Off[/center]"
	if Global.userConfig.music:
		settings_buttons.get_node("Music/Text").bbcode_text = "[center]Music: On[/center]"
	else:
		settings_buttons.get_node("Music/Text").bbcode_text = "[center]Music: Off[/center]"
	if Global.userConfig.fullscreen:
		settings_buttons.get_node("Fullscreen/Text").bbcode_text = "[center]Fullscreen: On[/center]"
	else:
		settings_buttons.get_node("Fullscreen/Text").bbcode_text = "[center]Fullscreen: Off[/center]"

func playClick():
	Events.emit_signal("play_sound", "menu_click")
	
func play_button_Click():
	Events.emit_signal("play_sound", "play_click")
	
func back_button_Click():
	Events.emit_signal("play_sound", "back_click")
	
func settings_change_Click():
	Events.emit_signal("play_sound", "change_setting")

func _on_Sound_button_up():
	settings_change_Click()
	Events.emit_signal("switch_sound", !Global.userConfig.sound)

func _on_Music_button_up():
	settings_change_Click()
	Events.emit_signal("switch_music", !Global.userConfig.music)

func _on_Fullscreen_button_up():
	settings_change_Click()
	Events.emit_signal("switch_fullscreen", !Global.userConfig.fullscreen)
	updateSettings()

func _on_SettingsButton_button_up():
	playClick()
	switchButton(ButtonState.Settings)

func _on_BackButton_button_up():
	back_button_Click()
	if back_flag == false:
		switchButton(ButtonState.Back)
	elif back_flag == true and menu_flag == true:
		get_tree().paused = false
		hide()

func _on_Other_button_up():
	playClick()
	switchButton(ButtonState.Other)

func _on_HighScores_button_up():
	update_highscores()
	playClick()
	switchButton(ButtonState.Highscores)

func update_highscores():
	empty_text()
	if Global.last_level == 1:
		var level = Highscores.level1
		update_text(level)
	if Global.last_level == 2:
		var level = Highscores.level2
		update_text(level)
	if Global.last_level == 3:
		var level = Highscores.level3
		update_text(level)
	if Global.last_level == 4:
		var level = Highscores.level4
		update_text(level)
	if Global.last_level == 5:
		var level = Highscores.level5
		update_text(level)
	if Global.last_level == 6:
		var level = Highscores.level6
		update_text(level)
	if Global.last_level == 7:
		var level = Highscores.level7
		update_text(level)
	if Global.last_level == 8:
		var level = Highscores.level8
		update_text(level)
	if Global.last_level == 9:
		var level = Highscores.level9
		update_text(level)

func empty_text():
	score_labels.get_node("HBoxContainer/score").text = " "
	score_labels.get_node("HBoxContainer2/score").text = " "
	score_labels.get_node("HBoxContainer3/score").text = " "
	score_labels.get_node("HBoxContainer4/score").text = " "
	score_labels.get_node("HBoxContainer5/score").text = " "

func update_text(level):
	if level.size() > 0:
		score_labels.get_node("HBoxContainer/score").text = str(level[0])
	elif level.size() == 0:
		score_labels.get_node("HBoxContainer/score").text = str(0)
	if level.size() > 1:
		score_labels.get_node("HBoxContainer2/score").text = str(level[1])
	elif level.size() == 1:
		score_labels.get_node("HBoxContainer2/score").text = str(0)
	if level.size() > 2:
		score_labels.get_node("HBoxContainer3/score").text = str(level[2])
	elif level.size() == 2:
		score_labels.get_node("HBoxContainer3/score").text = str(0)
	if level.size() > 3:
		score_labels.get_node("HBoxContainer4/score").text = str(level[3])
	elif level.size() == 3:
		score_labels.get_node("HBoxContainer4/score").text = str(0)
	if level.size() > 4:
		score_labels.get_node("HBoxContainer5/score").text = str(level[4])
	elif level.size() == 4:
		score_labels.get_node("HBoxContainer5/score").text = str(0)
