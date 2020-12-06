extends Node

onready var splash_screen := preload("res://src/screen/SplashScreen.tscn")
onready var main_screen := preload("res://src/screen/MainScreen.tscn")
onready var customization_screen := preload("res://src/screen/CustomizationScreen.tscn")
onready var level := preload("res://src/level/Level.tscn")
onready var os := OS.get_name()

var info_string_name : Dictionary = {
	0: "Deathguy",
	1: "Godot"
}

var info_string_url : Dictionary = {
	0: "https://amdotblacksheep.itch.io/deathguy",
	1: "https://godotengine.org/"
}
