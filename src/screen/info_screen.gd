extends WindowDialog


onready var label := $RichTextLabel
onready var tween := $Tween

var info_string := "He is %s.\n\nHe's a friend of mine so treat him well. Click on the link below and say hi.\n\n[color=#0000EE][url]%s[/url][/color]"

func _on_info_triggered(type : int) -> void:
	label.set_bbcode(
		info_string % [Main.info_string_name[type], 
		Main.info_string_url[type]])
	label.set_percent_visible(0)
	popup()
	tween.interpolate_property(
		label, "percent_visible", 0, 1, 1.5, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_Meta_clicked(meta) -> void:
	OS.shell_open(meta)
