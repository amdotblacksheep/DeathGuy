extends Control


signal unlocked(index)


onready var label := $RichTextLabel
onready var button_sfx := $ButtonSFX
onready var error_sfx := $ErrorSFX

var object : Node
var method : String
var index : int
var cost : int
var text := "[center]Are you willing to give %d coins to unlock it?[center]"


func _on_ShowUnlock(new_object : Node, new_method : String, new_index : int, new_cost : int) -> void:
	connect("unlocked", new_object, new_method)
	object = new_object
	method = new_method
	index = new_index
	cost = new_cost
	label.set_bbcode(text % cost)
	show()

func _on_YesButton_pressed() -> void:
	if UserData.wallet >= cost:
		button_sfx.play()
		emit_signal("unlocked", index)
	else:
		error_sfx.play()
	disconnect("unlocked", object, method)
	set_visible(false)

func _on_NoButton_pressed() -> void:
	button_sfx.play()
	disconnect("unlocked", object, method)
	set_visible(false)
