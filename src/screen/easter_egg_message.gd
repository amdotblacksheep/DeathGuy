extends Control


onready var label := $TextureRect/CenterContainer/RichTextLabel
onready var button_sfx := $ButtonSFX
onready var anim_play := $AnimationPlayer

var info_string := "[center]\nMessage for the developer:\n\n\n[shake rate=5 level=10][rainbow freq=0.2 sat=10 val=20][b]DEATH IS A LIE[/b][/rainbow][/shake]\n\n\n[img=128]res://assets/player/deathguy.png[/img][/center]"


func _on_ShowEE() -> void:
	label.set_bbcode(info_string)
	anim_play.play("pop_up")
	show()

func _on_ExitButton_pressed() -> void:
	button_sfx.play()
	anim_play.play("RESET")
	set_visible(false)
