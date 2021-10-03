extends Panel


onready var label := $VBoxContainer/CenterContainer/RichTextLabel
onready var next_button := $VBoxContainer/NextButton
onready var elements := $VBoxContainer/Elements
onready var button_sfx := $ButtonSFX
onready var tween := $Tween
onready var anim_play := $AnimationPlayer


var string : Dictionary = {
	0: "[center]Do you remember that people have two hands, right? Well, use them both to tilt your device so that I can move left and right.[/center]", 
	1: "[center]Man! Can you be a little careful? Make sure I don't have to touch the ereasers and don't make me disappear forever...If you are a brave noob and you get close enough, your score will increase![/center]",  
	2: "[center]Lucky for you, it was just a simulation... You're really bad at it...[/center]"
	}

var pc_string := "[center]Do you remember that people have two hands, right? Well, press A-D or Left-Right so that I can move left and right.[/center]"
var phase := 0


func _on_UpdateTutorial() -> void:
	set_visible(true)
	get_tree().set_pause(true)
	label.set_percent_visible(0)
	label.set_bbcode(string[phase])
	if phase == 0 and Main.os != "Android":
		label.set_bbcode(pc_string)
	
	tween.interpolate_property(
		label, "percent_visible", 0, 1, 0.5, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	if phase == 1:
		elements.show()
		anim_play.play("elements_anim")
	
	if phase < string.size() - 1:
		return
	
	next_button.disconnect("pressed", self, "_on_NextButton_pressed")
	next_button.connect("pressed", self, "_on_ExitButton_pressed")
	next_button.set_text("Exit!")


func _on_NextButton_pressed() -> void:
	phase += 1
	if elements.is_visible():
		elements.set_visible(false)
		anim_play.stop()
	button_sfx.play()
	yield(button_sfx, "finished")
	set_visible(false)
	get_tree().set_pause(false)


func _on_ExitButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	BackGroundMusic.stop()
	get_tree().change_scene_to(Main.main_screen)
