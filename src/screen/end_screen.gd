extends Control


signal second_chance()


onready var level := get_node("/root/Level")
onready var admob := $AdMob
onready var admob_debugger := $CanvasLayer/AdMobDebug
onready var fake_ads := $FakeAds
onready var adsbutton := $VBoxContainer/AdsButton
onready var record := $Label
onready var button_sfx := $ButtonSFX
onready var anim_play := $AnimationPlayer

var rewarded := false
var is_fake_ads = true


func _ready() -> void:
	fake_ads.connect("fake_ads_closed", self, "_on_Fake_Ads_closed")
	if (Engine.has_singleton("GodotAdMob")):
		adsbutton.set_disabled(true)
		admob.load_rewarded_video()
		is_fake_ads = false
#	else:
#		admob_debugger.label.set_text("AdMob Java Singleton not found. This plugin will only work on Android")

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
	if not is_fake_ads:
		admob.show_rewarded_video()
	else:
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

func _on_AdMob_rewarded_video_loaded() -> void:
#	admob_debugger.label.set_text("Rewarded video ad loaded.")
	adsbutton.set_disabled(false)

func _on_AdMob_rewarded_video_failed_to_load(error_code : int) -> void:
#	admob_debugger.label.set_text("Rewarded video ad failed to load with error : %d." % error_code)
	adsbutton.set_disabled(false)
	is_fake_ads = true

func _on_AdMob_rewarded(_currency : String, _ammount : int) -> void:
#	admob_debugger.label.set_text("Rewarded video ad rewarded.")
	rewarded = true
	adsbutton.set_disabled(true)
	emit_signal("second_chance")

func _on_AdMob_rewarded_video_closed() -> void:
	if not rewarded:
#		admob_debugger.label.set_text("Rewarded video ad closed.")
		admob.load_rewarded_video()
	BackGroundMusic.set_stream_paused(false)

