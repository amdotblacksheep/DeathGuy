extends Control

signal can_show_ads()

onready var label := $ColorRect/CenterContainer/RichTextLabel
onready var button_sfx := $ButtonSFX
onready var anim_play := $AnimationPlayer

var ads_warning := "[center]\nView this ad to %s![/center]"


func _on_ShowWarning(string : String) -> void:
	label.set_bbcode(ads_warning % string)
	anim_play.play("pop_up")
	show()

func _on_ExitButton_pressed() -> void:
	button_sfx.play()
	anim_play.play("RESET")
	set_visible(false)

func _on_OKButton_pressed() -> void:
	button_sfx.play()
	anim_play.play("RESET")
	set_visible(false)
	emit_signal("can_show_ads")
