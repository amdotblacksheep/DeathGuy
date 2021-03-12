extends Node

onready var splash_screen := preload("res://src/screen/SplashScreen.tscn")
onready var main_screen := preload("res://src/screen/MainScreen.tscn")
onready var customization_screen := preload("res://src/screen/CustomizationScreen.tscn")
onready var level := preload("res://src/level/Level.tscn")
onready var tutorial := preload("res://src/level/Tutorial.tscn")
onready var os := OS.get_name()

onready var info_string_name : Dictionary = {
	0: "Deathguy",
	1: "Godot",
	2: "Kiki",
	3: "Ace",
	4: "Ardy",
	5: "Helm",
	6: "Itch",
	7: "Octocat",
	8: "Gnu",
	9: "Tux"
}

onready var info_string_url : Dictionary = {
	0: "https://amdotblacksheep.itch.io/deathguy",
	1: "https://godotengine.org/",
	2: "https://krita.org/",
	3: "https://www.aseprite.org/",
	4: "https://ardour.org/",
	5: "https://tytel.org/helm/",
	6: "https://itch.io/",
	7: "https://github.com/",
	8: "http://www.gnu.org/gnu/gnu.html",
	9: "https://www.linuxfoundation.org/"
}

onready var ads_reward_string : Dictionary = {
	0 : "receive %d coins",
	1 : "respawn"
}

onready var fake_ads_img : Dictionary = {
	0: preload("res://assets/fakeads/banner_amdbs.jpeg"),
	1: preload("res://assets/fakeads/banner_deathguy.jpeg")
}

onready var fake_ads_text : Dictionary = {
	0: "[b]More about am.blacksheep![/b]\n\nHi, I'm Alexander aka am.blacksheep.\nFor more information you can visit my blog!",
	1: "[b]Deathguy is also avaible on Itch![/b]\n\nHey! I need your help also on Itch.io!"
}

onready var fake_ads_url : Dictionary = {
	0: "https://amdotblacksheep.blogspot.com/",
	1: "https://amdotblacksheep.itch.io/deathguy"
}
