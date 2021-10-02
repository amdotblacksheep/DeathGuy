extends Node


var color : Array = ["e2e2e2", "d32b3b", "354786", "1d7e46", "39a9d0", "81365f", "debf2f", "d96638"]
var head : Array = []
var body : Array = []
var background : Array = []

var head_dir := "res://assets/player/head"
var body_dir := "res://assets/player/body"
var back_dir := "res://assets/background"


func _init() -> void:
	var dir := Directory.new()
	
	if dir.open(head_dir) == OK:
		dir.list_dir_begin()
		var file_name := dir.get_next()
		while(file_name != ""):
			if file_name.ends_with(".png.import"):
				file_name = file_name.replace(".import", "")
				head.append(file_name)
			file_name = dir.get_next()
	head.sort()
	
	if dir.open(body_dir) == OK:
		dir.list_dir_begin()
		var file_name := dir.get_next()
		while(file_name != ""):
			if file_name.ends_with(".png.import"):
				file_name = file_name.replace(".import", "")
				body.append(file_name)
			file_name = dir.get_next()
	body.sort()
	
	if dir.open(back_dir) == OK:
		dir.list_dir_begin()
		var file_name := dir.get_next()
		while(file_name != ""):
			if file_name.ends_with(".png.import"):
				file_name = file_name.replace(".import", "")
				background.append(file_name)
			file_name = dir.get_next()
	background.sort()
