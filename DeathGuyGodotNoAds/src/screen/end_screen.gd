extends Control


signal second_chance()


onready var level := get_node("/root/Level")
onready var fake_ads := $FakeAds
onready var adsbutton := $VBoxContainer/AdsButton
onready var record := $Label
onready var button_sfx := $ButtonSFX
onready var anim_play := $AnimationPlayer

var rewarded := false


func _ready() -> void:
	fake_ads.connect("fake_ads_closed", self, "_on_Fake_Ads_closed")

func _on_UpdateRecord(new_record : int) -> void:
	record.set_text("Your record: %d" % new_record)

func _on_RetryButton_pressed() -> void:
	level.coin = level.score / 10
	UserData.wallet += level.coin
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().reload_current_scene()

func _on_AdsButton_pressed() -> void:
	BackGroundMusic.set_stream_paused(true)
	button_sfx.play()
	yield(button_sfx, "finished")
	fake_ads.show_ads(15)

func _on_ExitButton_pressed() -> void:
	level.coin = level.score / 10
	UserData.wallet += level.coin
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	BackGroundMusic.stop()
	get_tree().change_scene_to(Main.main_screen)

func _on_CustomizeButton_pressed() -> void:
	level.coin = level.score / 10
	UserData.wallet += level.coin
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	BackGroundMusic.stop()
	get_tree().change_scene_to(Main.customization_screen)

func _on_Fake_Ads_closed() -> void:
	rewarded = true
	adsbutton.set_disabled(true)
	emit_signal("second_chance")
	BackGroundMusic.set_stream_paused(false)
