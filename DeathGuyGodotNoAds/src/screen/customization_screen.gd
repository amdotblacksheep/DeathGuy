extends Control


onready var unlock_screen := $UnlockScreen
onready var info_screen := $InfoScreen
onready var coin := $Coin/Label
onready var fake_ads := $FakeAds
onready var adsbutton := $VBoxContainer/AdsButton
onready var button_sfx := $ButtonSFX

var rewarded := false
var coin_reward := 150

func _ready() -> void:
	SaveLoad.load_game()
	fake_ads.connect("fake_ads_closed", self, "_on_Fake_Ads_closed")
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
