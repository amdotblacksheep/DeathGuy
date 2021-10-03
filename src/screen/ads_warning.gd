extends AcceptDialog

signal can_show_ads()

onready var label := $RichTextLabel
onready var tween := $Tween

var ads_warning := "Take a look at this ad to %s"


func _on_ads_warning_triggered(string : String) -> void:
	var text : String
	if UserData.ads:
		text = ads_warning % string
	else:
		text = "Noob... do you wanna respawn?"
	label.set_bbcode(text)
	label.set_percent_visible(0)
	popup()
	tween.interpolate_property(
		label, "percent_visible", 0, 1, 0.5, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

