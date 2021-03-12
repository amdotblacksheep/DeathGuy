#tool
extends GridContainer


#const COLORS := [
#	"e2e2e2", 
#	"d32b3b", 
#	"1d7e46", 
#	"354786", 
#	"39a9d0", 
#	"81365f", 
#	"debf2f", 
#	"d96638"
#]
#
#var Switch : PackedScene = preload("res://src/screen/ColorSwitch.tscn")
#
#var color := Color.white
#
#
#func _ready() -> void:
#	for color in COLORS:
#		var switch : ColorSwitch = Switch.instance()
#		switch.color = color
#		add_child(switch)
#		switch.set_owner(get_tree().edited_scene_root)
#		switch.connect("pressed", self, "_on_ColorSwitch_pressed", [color])
#
#func _on_ColorSwitch_pressed(color_string : String) -> void:
#	color = Color(color_string)
