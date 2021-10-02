extends Control


onready var label := $VBoxContainer/CenterContainer/RichTextLabel
onready var next_button := $VBoxContainer/NextButton
onready var button_sfx := $ButtonSFX


var string : Dictionary = {
	0: "[center]Tilt the device to move left or right![/center]", 
	1: "[center]Warning! Don't touch the erasers or you'll disappear forever! If you are brave enough to move closer to them your score will increase![/center]", 
	2: "[center]Click on \"a second chance!\" to respawn![/center]", 
	3: "[center]Thanks for playing the tutorial![/center]"
	}
var phase := 0


func _on_UpdateTutorial() -> void:
	set_visible(true)
	get_tree().set_pause(true)
	if phase < string.size() - 1:
		label.set_bbcode(string[phase])
	else:
		label.set_bbcode(string[phase])
		next_button.disconnect("pressed", self, "_on_NextButton_pressed")
		next_button.connect("pressed", self, "_on_ExitButton_pressed")
		next_button.set_text("Exit!")
	phase += 1


func _on_NextButton_pressed() -> void:
	button_sfx.play()
	yield(button_sfx, "finished")
	set_visible(false)
	if phase != 3:
		get_tree().set_pause(false)


func _on_ExitButton_pressed() -> void:
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().change_scene_to(Main.main_screen)
