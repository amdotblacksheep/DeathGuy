extends WindowDialog


onready var label := $RichTextLabel
onready var tween := $Tween

func _on_EEGame_dialog_triggered(string : String) -> void:
	label.set_bbcode(string)
	label.set_percent_visible(0)
	popup()
	tween.interpolate_property(
		label, "percent_visible", 0, 1, 1.0, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	get_tree().set_pause(true)


