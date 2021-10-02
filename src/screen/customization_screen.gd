extends Control


onready var admob := $AdMob
onready var admob_debugger := $CanvasLayer/AdMobDebug
onready var unlock_screen := $UnlockScreen
onready var info_screen := $InfoScreen
onready var fake_ads := $FakeAds
onready var coin := $Coin/Label
onready var adsbutton := $VBoxContainer/AdsButton
onready var button_sfx := $ButtonSFX

var rewarded := false
var is_fake_ads = true
var coin_reward := 150

func _ready() -> void:
	SaveLoad.load_game()
	if not BackGroundMusic.is_playing():
		BackGroundMusic.set_stream(load(Data.menum_dir + '/' + Data.menumusic[0]))
		BackGroundMusic.play()
	fake_ads.connect("fake_ads_closed", self, "_on_Fake_Ads_closed")
	if (Engine.has_singleton("GodotAdMob")):
		adsbutton.set_disabled(true)
		admob.load_rewarded_video()
		is_fake_ads = false
#	else:
#		admob_debugger.label.set_text("AdMob Java Singleton not found. This plugin will only work on Android.")
	get_tree().set_pause(false)
	coin.text = str(UserData.wallet)

func _on_PlayButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().change_scene_to(Main.level)

func _on_AdsButton_pressed() -> void:
	BackGroundMusic.set_stream_paused(true)
	button_sfx.play()
	yield(button_sfx, "finished")
	if not is_fake_ads:
		admob.show_rewarded_video()
	else:
		fake_ads.show_ads(15)

func _on_ExitButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().change_scene_to(Main.main_screen)

func _on_Fake_Ads_closed() -> void:
	UserData.wallet += coin_reward
	coin.text = str(UserData.wallet)
	rewarded = true
	adsbutton.set_disabled(true)
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
	UserData.wallet += coin_reward
	coin.text = str(UserData.wallet)
	rewarded = true
	adsbutton.set_disabled(true)

func _on_AdMob_rewarded_video_closed() -> void:
	is_fake_ads = true
	if not rewarded:
#		admob_debugger.label.set_text("Rewarded video ad closed.")
		admob.load_rewarded_video()
	BackGroundMusic.set_stream_paused(false)
