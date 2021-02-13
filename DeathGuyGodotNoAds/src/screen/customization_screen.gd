extends Control


signal show_ads_warning(string)


onready var unlock_screen := $UnlockScreen
onready var info_screen := $InfoScreen
onready var ads_warning := $AdsWarning
onready var coin := $Coin/Label
onready var fake_ads := $FakeAds
onready var adsbutton := $VBoxContainer/AdsButton
onready var button_sfx := $ButtonSFX

var rewarded := false
var coin_reward := 150

func _ready() -> void:
	SaveLoad.load_game()
	if not BackGroundMusic.is_playing():
		BackGroundMusic.set_stream(load(Data.menum_dir + '/' + Data.menumusic[0]))
		BackGroundMusic.play()
	fake_ads.connect("fake_ads_closed", self, "_on_Fake_Ads_closed")
	connect("show_ads_warning", ads_warning, "_on_ShowWarning")
	ads_warning.connect("can_show_ads", self, "_on_CanShow_Ads")
	get_tree().set_pause(false)
	coin.text = str(UserData.wallet)

func _on_PlayButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().change_scene_to(Main.level)

func _on_AdsButton_pressed() -> void:
	button_sfx.play()
	yield(button_sfx, "finished")
	emit_signal("show_ads_warning", Main.ads_reward_string[0] % [coin_reward])

func _on_CanShow_Ads() -> void:
	BackGroundMusic.set_stream_paused(true)
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
