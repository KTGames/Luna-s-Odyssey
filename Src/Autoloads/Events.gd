extends Node

#warning-ignore-all:unused_signal

###############################################################################
# Global Signal List
###############################################################################

# Level Management
signal new_game()
signal continue_game()

# Sound
signal play_sound(sound, volume, pos)

# Menu Related
signal menu_back()

# Config
signal switch_sound(value)
signal switch_music(value)
signal switch_fullscreen(value)

# Game Signals
signal pickup
signal dead
signal no_mini_map
signal end_level
signal new_highscore
###############################################################################

# Global Event Connect Function
func connect_signal(tSignal: String, target: Object, method: String):
	#warning-ignore:return_value_discarded
	connect(tSignal, target, method)
