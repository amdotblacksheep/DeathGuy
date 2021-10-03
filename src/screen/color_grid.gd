#tool
extends GridContainer
#
#
#const COLORS := [
#	"e5e5e5", 
#	"d62838", 
#	"197f42", 
#	"334784", 
#	"33a9d0", 
#	"843360", 
#	"e0c12f", 
#	"db6638"
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
