extends Node

# Version
const GAME_VERSION = 0.1
const CONFIG_VERSION = 0 # Used for config migration
# Debug Options
const DEBUG = false


const levels = [
	"res://Src/Menu/Cutscene.tscn",
	"res://Src/Levels/Level 1.tscn",
	"res://Src/Levels/Level 2.tscn",
	"res://Src/Levels/Level 3.tscn",
	"res://Src/Levels/Level 4.tscn",
	"res://Src/Levels/Level 5.tscn",
	"res://Src/Levels/Level 6.tscn",
	"res://Src/Levels/Level 7.tscn",
	"res://Src/Levels/level 8.tscn",
	"res://Src/Levels/Level 9.tscn",
	]

# User Config - These are also the default values
var userConfig = {
	"configVersion": CONFIG_VERSION,
	"highscore": 0,
	"sound": true,
	"music": true,
	"fullscreen": false
}
#####################
#    Global Vars    #
#####################
var new_game_flag = true as bool
var last_level 
var points = 0 
var max_pickups = 0
var got_pickups = 0

# Config Save
func saveConfig():
	var cfgFile = File.new()
	cfgFile.open("user://config.cfg", File.WRITE)
	cfgFile.store_line(to_json(userConfig))
	cfgFile.close()

# Config Load
func loadConfig():
	var cfgFile = File.new()
	if not cfgFile.file_exists("user://config.cfg"):
		saveConfig()
		return
	
	cfgFile.open("user://config.cfg", File.READ)
	var data = parse_json(cfgFile.get_line())
	
	# Check if the user has an old config, so update it
	if data.configVersion < CONFIG_VERSION:
		data = migrateConfig(data)
		saveConfig()
	
	# Copy over userConfig
	userConfig.highscore = data.highscore
	userConfig.fullscreen = data.fullscreen
	userConfig.sound = data.sound
	userConfig.music = data.music
	# When stuck here, the config attributes have been changed.
	# Delete the Config.cfg to solve this issue.
	# Project->Open Project Data Folder-> Config.cfg
	#
	# Sure this can be just copied, but you may miss if some settings are not
	# saved correctly. Also for updates please consider the migration mechanism.

# Config Migration
func migrateConfig(data):
#	for i in range(data.configVersion, CONFIG_VERSION):
#		match data.configVersion:
#			0:
#				update config here
#				data.configVersion = 1
#			_:
#				print("error: migration variant not found")
	return data

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting: " + str(ProjectSettings.get_setting("application/config/name")) + " v" + getVersionString())
	print("Debug: " + str(OS.is_debug_build()))
	print("Soft-Debug: "+ str(DEBUG))
	loadConfig()
	#videoSetup(2)
	switchFullscreen()


func Time(time: float):
	var t = Timer.new()
	t.set_wait_time(time)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()

# Window Scaler
#func videoSetup(scale = 2):
	#var initSize = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))
	#var screen_size = OS.get_screen_size(OS.get_current_screen())
	#var window_size = initSize * scale
	#var centered_pos = (screen_size - window_size) / 2
	#OS.set_window_position(centered_pos)
	#OS.set_window_size(window_size)


# Set Fullscreen Mode
func setFullscreen(val: bool):
	userConfig.fullscreen = val
	saveConfig()
	
	switchFullscreen()


# Perform Fullscreen Switch
func switchFullscreen():
	if not userConfig.fullscreen:
		OS.window_fullscreen = false
		#videoSetup(2)
	else:
		#videoSetup(3)
		OS.window_fullscreen = true


# Get Version
func getVersion():
	return GAME_VERSION
	
# Get Version String
func getVersionString():
	var versionString = "%2.1f" % (GAME_VERSION) 
	
	if DEBUG:
		versionString += "-debug"

	return versionString
