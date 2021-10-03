extends Node


var score_record : int = 0
var wallet : int = 0
var last_color : int = 0
var last_head : int = 0
var last_body : int = 0
var last_background : int = 0
var unlocked_color : Array = [0]
var unlocked_head : Array = [0]
var unlocked_body : Array = [0]
var unlocked_background : Array = [0]
var tutorial : bool = true
var bus : Dictionary = {
	"master" : 9,
	"sfx" : 9,
	"music" : 9
}
var ads : bool = true


func save() -> Dictionary:
	var save_dict : Dictionary = {
		"node": get_path(),
		"score_record" : score_record,
		"wallet" : wallet,
		"last_color" : last_color,
		"last_head" :last_head,
		"last_body" : last_body,
		"last_background" : last_background,
		"unlocked_color": unlocked_color,
		"unlocked_head" : unlocked_head,
		"unlocked_body" : unlocked_body,
		"unlocked_background": unlocked_background,
		"tutorial" : tutorial,
		"bus" : bus,
		"ads" : ads
		}
	return save_dict
