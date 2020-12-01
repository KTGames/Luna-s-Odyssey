extends Control

enum MenuState {Main, Settings, Levels, Highscore}

onready var gm = get_parent().get_parent().get_parent()
onready var anim = gm.get_node("anim")
onready var buttons = $Levels/GridContainer
onready var hs_buttons = $Highscores/VBoxContainer/NinePatchRect2/HBoxContainer
onready var score_labels = $Highscores/VBoxContainer/NinePatchRect/MarginContainer/HBoxContainer/VBoxContainer
onready var level_label = $Highscores/VBoxContainer/NinePatchRect/MarginContainer/HBoxContainer/RichTextLabel

func _ready():
	# Event Hooks
	Events.connect_signal("menu_back", self, "_back")
	Events.connect_signal("switch_sound", self, "_switchSound")
	Events.connect_signal("switch_music", self, "_switchMusic")
	Events.connect_signal("switch_fullscreen", self, "_switchFullscreen")

	#$Version.bbcode_text = "[right]"+ Global.getVersionString() + "[/right]"

	switchTo(MenuState.Main)

# Play menu button sound
func playClick():
	Events.emit_signal("play_sound", "menu_click")
	
func play_button_Click():
	Events.emit_signal("play_sound", "play_click")
	
func back_button_Click():
	Events.emit_signal("play_sound", "back_click")
	
func settings_change_Click():
	Events.emit_signal("play_sound", "change_setting")

# Menu State Transition
func switchTo(to):
	hideAllMenuScenes()

	match to:
		MenuState.Main:
			$Main.show()
			$TitleText.show()
		MenuState.Settings:
			updateSettings()
			$Settings.show()
		MenuState.Levels:
			$Levels.show()
		MenuState.Highscore:
			$Highscores.show()
		_:
			print("Invalid menu state")

# Helper function for State Transition
func hideAllMenuScenes():
	# Add menu scenes here
	$Main.hide()
	$Settings.hide()
	$Levels.hide()
	$TitleText.hide()
	$Highscores.hide()
	
# Helper function to update levels unlocked
func if_unlocked():
	if Highscores.level1_unlocked == false:
		buttons.get_node("Level1").disabled = true
		hs_buttons.get_node("1").disabled = true
	else:
		buttons.get_node("Level1").disabled = false
		hs_buttons.get_node("1").disabled = false
	if Highscores.level2_unlocked == false:
		buttons.get_node("Level2").disabled = true
		hs_buttons.get_node("2").disabled = true
	else:
		buttons.get_node("Level2").disabled = false
		hs_buttons.get_node("2").disabled = false
	if Highscores.level3_unlocked == false:
		buttons.get_node("Level3").disabled = true
		hs_buttons.get_node("3").disabled = true
	else:
		buttons.get_node("Level3").disabled = false
		hs_buttons.get_node("3").disabled = false
	if Highscores.level4_unlocked == false:
		buttons.get_node("Level4").disabled = true
		hs_buttons.get_node("4").disabled = true
	else:
		buttons.get_node("Level4").disabled = false
		hs_buttons.get_node("4").disabled = false
	if Highscores.level5_unlocked == false:
		buttons.get_node("Level5").disabled = true
		hs_buttons.get_node("5").disabled = true
	else:
		buttons.get_node("Level5").disabled = false
		hs_buttons.get_node("5").disabled = false
	if Highscores.level6_unlocked == false:
		buttons.get_node("Level6").disabled = true
		hs_buttons.get_node("6").disabled = true
	else:
		buttons.get_node("Level6").disabled = false
		hs_buttons.get_node("6").disabled = false
	if Highscores.level7_unlocked == false:
		buttons.get_node("Level7").disabled = true
		hs_buttons.get_node("7").disabled = true
	else:
		buttons.get_node("Level7").disabled = false
		hs_buttons.get_node("7").disabled = false
	if Highscores.level8_unlocked == false:
		buttons.get_node("Level8").disabled = true
		hs_buttons.get_node("8").disabled = true
	else:
		buttons.get_node("Level8").disabled = false
		hs_buttons.get_node("8").disabled = false
	if Highscores.level9_unlocked == false:
		buttons.get_node("Level9").disabled = true
		hs_buttons.get_node("9").disabled = true
	else:
		buttons.get_node("Level9").disabled = false
		hs_buttons.get_node("9").disabled = false
		
# Helper function to update the config labels
func updateSettings():
	if Global.userConfig.sound:
		$Settings/VBoxContainer/Sound/Text.bbcode_text = "[center]Sound: On[/center]"
	else:
		$Settings/VBoxContainer/Sound/Text.bbcode_text = "[center]Sound: Off[/center]"
	
	if Global.userConfig.music:
		$Settings/VBoxContainer/Music/Text.bbcode_text = "[center]Music: On[/center]"
	else:
		$Settings/VBoxContainer/Music/Text.bbcode_text = "[center]Music: Off[/center]"

	if Global.userConfig.fullscreen:
		$Settings/VBoxContainer/Fullscreen/Text.bbcode_text = "[center]Fullscreen: On[/center]"
	else:
		$Settings/VBoxContainer/Fullscreen/Text.bbcode_text = "[center]Fullscreen: Off[/center]"

###############################################################################
# Callbacks
###############################################################################

# Event Hook
func _switchSound(_val):
	updateSettings()

# Event Hook
func _switchMusic(_val):
	updateSettings()

# Event Hook
func _switchFullscreen(_val):
	updateSettings()

# Event Hook
func _back():
	back_button_Click()
	switchTo(MenuState.Main)


func _on_Play_button_up():
	var save_data = File.new()
	if save_data.file_exists("user://savedata.save"):
		Events.emit_signal("continue_game")
		Global.new_game_flag = false
		playClick()
	else:
		save_data.open("user://savedata.save", File.WRITE)
		save_data.store_line(to_json("hi"))
		Events.emit_signal("new_game")
		Global.new_game_flag = true
		play_button_Click()
	save_data.close()

func _on_Back_button_up():
	back_button_Click()
	switchTo(MenuState.Main)


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

func _on_Settings_button_up():
	updateSettings()
	playClick()
	switchTo(MenuState.Settings)


func _on_Exit_button_up():
	back_button_Click()
	print("Ok, Bye! Thanks for playing.")
	get_tree().quit()


func _on_Level1_button_up():
	play_button_Click()
	anim.play("fade_out")
	gm.loadLevel(1)

func _on_Level2_button_up():
	play_button_Click()
	anim.play("fade_out")
	gm.loadLevel(2)


func _on_Back_Button_button_up():
	back_button_Click()
	switchTo(MenuState.Main)


func _on_Level3_pressed():
	play_button_Click()
	anim.play("fade_out")
	gm.loadLevel(3)
	
	
func _on_Level4_button_up():
	play_button_Click()
	anim.play("fade_out")
	gm.loadLevel(4)
	
func _on_Level5_button_up():
	play_button_Click()
	anim.play("fade_out")
	gm.loadLevel(5)

func _on_Level6_button_up():
	play_button_Click()
	anim.play("fade_out")
	gm.loadLevel(6)

func _on_Level7_button_up():
	play_button_Click()
	anim.play("fade_out")
	gm.loadLevel(7)
	
func _on_Level8_button_up():
	play_button_Click()
	anim.play("fade_out")
	gm.loadLevel(8)
	
func _on_Level9_button_up():
	play_button_Click()
	anim.play("fade_out")
	gm.loadLevel(9)
	
func _on_Highscores_button_up():
	play_button_Click()
	switchTo(MenuState.Highscore)

func update_text(level):
	if level:
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


func _on_1_button_up():
	back_button_Click()
	level_label.bbcode_text = "[center]Level 1[/center]"
	var level = Highscores.level1
	update_text(level)

func _on_2_button_up():
	back_button_Click()
	level_label.bbcode_text = "[center]Level 2[/center]"
	var level = Highscores.level2
	update_text(level)

func _on_3_button_up():
	back_button_Click()
	level_label.bbcode_text = "[center]Level 3[/center]"
	var level = Highscores.level3
	update_text(level)

func _on_4_button_up():
	back_button_Click()
	level_label.bbcode_text = "[center]Level 4[/center]"
	var level = Highscores.level4
	update_text(level)

func _on_5_button_up():
	back_button_Click()
	level_label.bbcode_text = "[center]Level 5[/center]"
	var level = Highscores.level5
	update_text(level)

func _on_6_button_up():
	back_button_Click()
	level_label.bbcode_text = "[center]Level 6[/center]"
	var level = Highscores.level6
	update_text(level)

func _on_7_button_up():
	back_button_Click()
	level_label.bbcode_text = "[center]Level 7[/center]"
	var level = Highscores.level7
	update_text(level)

func _on_8_button_up():
	back_button_Click()
	level_label.bbcode_text = "[center]Level 8[/center]"
	var level = Highscores.level8
	update_text(level)

func _on_9_button_up():
	back_button_Click()
	level_label.bbcode_text = "[center]Level 9[/center]"
	var level = Highscores.level9
	update_text(level)
