extends Control


onready var label := $ColorRect/CenterContainer/RichTextLabel
onready var button_sfx := $ButtonSFX
onready var anim_play := $AnimationPlayer

var info_string := "[center]Hi, i'm %s.\n\nFor more information about me please click the link belove.\n\n[url]%s[/url][/center]"


func _on_ShowInfo(type : int) -> void:
	label.set_bbcode(info_string % [Main.info_string_name[type], Main.info_string_url[type]])
	anim_play.play("pop_up")
	show()

func _on_ExitButton_pressed() -> void:
	button_sfx.play()
	anim_play.play("RESET")
	set_visible(false)

func _on_Meta_clicked(meta) -> void:
	button_sfx.play()
	yield(button_sfx, "finished")
	OS.shell_open(meta)
