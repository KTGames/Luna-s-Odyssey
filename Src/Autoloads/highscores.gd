extends Node

var level1 = [] 
var level2 = []
var level3 = []
var level4 = []
var level5 = []
var level6 = []
var level7 = []
var level8 = []
var level9 = []
var level1_unlocked = true as bool
var level2_unlocked = false as bool
var level3_unlocked = false as bool
var level4_unlocked = false as bool
var level5_unlocked = false as bool
var level6_unlocked = false as bool
var level7_unlocked = false as bool
var level8_unlocked = false as bool
var level9_unlocked = false as bool
var scores = {
	"level1": level1,
	"level2": level2,
	"level3": level3,
	"level4": level4,
	"level5": level5,
	"level6": level6,
	"level7": level7,
	"level8": level8,
	"level9": level9,
	"level1_unlocked": level1_unlocked,
	"level2_unlocked": level2_unlocked,
	"level3_unlocked": level3_unlocked,
	"level4_unlocked": level4_unlocked,
	"level5_unlocked": level5_unlocked,
	"level6_unlocked": level6_unlocked,
	"level7_unlocked": level7_unlocked,
	"level8_unlocked": level8_unlocked,
	"level9_unlocked": level9_unlocked,
}

func save_scores():
	var file = File.new()
	file.open("user://scores.json", file.WRITE)
	file.store_line(to_json(scores))
	file.close()
	
func load_scores():
	var file = File.new()
	if not file.file_exists("user://scores.json"):
		save_scores()
	else:
		file.open("user://scores.json", file.READ)
		var temp_data = file.get_as_text()
		
		var dict = {}
		dict = parse_json(temp_data)
		scores = dict
		level1 = dict["level1"]
		level2 = dict["level2"]
		level3 = dict["level3"]
		level4 = dict["level4"]
		level5 = dict["level5"]
		level6 = dict["level6"]
		level7 = dict["level7"]
		level8 = dict["level8"]
		level9 = dict["level9"]
		level1_unlocked = dict["level1_unlocked"]
		level2_unlocked = dict["level2_unlocked"]
		level3_unlocked = dict["level3_unlocked"]
		level4_unlocked = dict["level4_unlocked"]
		level5_unlocked = dict["level5_unlocked"]
		level6_unlocked = dict["level6_unlocked"]
		level7_unlocked = dict["level7_unlocked"]
		level8_unlocked = dict["level8_unlocked"]
		level9_unlocked = dict["level9_unlocked"]
		
		file.close()
		
class Descending:
	static func sort_descending(a, b):
		if a[0] > b[0]:
			return true
		return false

# Called when the node enters the scene tree for the first time.
func _ready():
	load_scores()
	Events.connect_signal("dead", self, "_new_score")
	Events.connect_signal("end_level", self, "_new_score")
	Events.connect_signal("end_level", self, "update_levels")

func _process(_delta):
	level1.sort()
	level1.invert()
	level2.sort()
	level2.invert()
	level3.sort()
	level3.invert()
	level4.sort()
	level4.invert()
	level5.sort()
	level5.invert()
	level6.sort()
	level6.invert()
	level7.sort()
	level7.invert()
	level8.sort()
	level8.invert()
	level9.sort()
	level9.invert()
	

func _new_score():
	var level_flag = Global.last_level
	if level_flag == 1:
		if level1.empty() == true:
			level1.append(Global.points)
			level1.append(0)
			Events.emit_signal("new_highscore")
		elif Global.points > level1[0]:
			level1.push_front(Global.points)
			Events.emit_signal("new_highscore")
		elif Global.points > level1[-1]:
			level1.append(Global.points)
	elif level_flag == 2:
		if level2.empty() == true:
			level2.append(Global.points)
			level2.append(0)
			Events.emit_signal("new_highscore")
		elif Global.points > level2[0]:
			level2.push_front(Global.points)
			Events.emit_signal("new_highscore")
		elif Global.points > level2[-1]:
			level2.append(Global.points)
	elif level_flag == 3:
		if level3.empty() == true:
			level3.append(Global.points)
			level3.append(0)
			Events.emit_signal("new_highscore")
		elif Global.points > level3[0]:
			level3.push_front(Global.points)
			Events.emit_signal("new_highscore")
		elif Global.points > level3[-1]:
			level3.append(Global.points)
	elif level_flag == 4:
		if level4.empty() == true:
			level4.append(Global.points)
			level4.append(0)
			Events.emit_signal("new_highscore")
		elif Global.points > level4[0]:
			level4.push_front(Global.points)
			Events.emit_signal("new_highscore")
		elif Global.points > level4[-1]:
			level4.append(Global.points)
	elif level_flag == 5:
		if level5.empty() == true:
			level5.append(Global.points)
			level5.append(0)
			Events.emit_signal("new_highscore")
		elif Global.points > level5[0]:
			level5.push_front(Global.points)
			Events.emit_signal("new_highscore")
		elif Global.points > level5[-1]:
			level5.append(Global.points)
	elif level_flag == 6:
		if level6.empty() == true:
			level6.append(Global.points)
			level6.append(0)
			Events.emit_signal("new_highscore")
		elif Global.points > level6[0]:
			level6.push_front(Global.points)
			Events.emit_signal("new_highscore")
		elif Global.points > level6[-1]:
			level6.append(Global.points)
	elif level_flag == 7:
		if level7.empty() == true:
			level7.append(Global.points)
			level7.append(0)
			Events.emit_signal("new_highscore")
		elif Global.points > level7[0]:
			level7.push_front(Global.points)
			Events.emit_signal("new_highscore")
		elif Global.points > level7[-1]:
			level7.append(Global.points)
	elif level_flag == 8:
		if level8.empty() == true:
			level8.append(Global.points)
			level8.append(0)
			Events.emit_signal("new_highscore")
		elif Global.points > level8[0]:
			level8.push_front(Global.points)
			Events.emit_signal("new_highscore")
		elif Global.points > level8[-1]:
			level8.append(Global.points)
	elif level_flag == 9:
		if level9.empty() == true:
			level9.append(Global.points)
			level9.append(0)
			Events.emit_signal("new_highscore")
		elif Global.points > level9[0]:
			level9.push_front(Global.points)
			Events.emit_signal("new_highscore")
		elif Global.points > level9[-1]:
			level9.append(Global.points)
	save_scores()

func update_levels():
	if Global.last_level == 1:
		level2_unlocked = true
		scores["level2_unlocked"] = level2_unlocked
	elif Global.last_level == 2:
		level3_unlocked = true
		scores["level3_unlocked"] = level3_unlocked
	elif Global.last_level == 3:
		level4_unlocked = true
		scores["level4_unlocked"] = level4_unlocked
	elif Global.last_level == 4:
		level5_unlocked = true
		scores["level5_unlocked"] = level5_unlocked
	elif Global.last_level == 5:
		level6_unlocked = true
		scores["level6_unlocked"] = level6_unlocked
	elif Global.last_level == 6:
		level7_unlocked = true
		scores["level7_unlocked"] = level7_unlocked
	elif Global.last_level == 7:
		level8_unlocked = true
		scores["level8_unlocked"] = level8_unlocked
	elif Global.last_level == 8:
		level9_unlocked = true
		scores["level9_unlocked"] = level9_unlocked
	save_scores()
