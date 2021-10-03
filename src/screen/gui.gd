extends Control

signal end_screen_triggered()
signal ads_warnig_triggered()
signal respawn_triggerd()

onready var admob := $AdMob
onready var fake_ads := $FakeAds
onready var admob_debugger := $CanvasLayer/AdMobDebug

onready var pause_screen := $CanvasLayer/PauseScreen
onready var end_screen := $CanvasLayer/EndScreen
onready var ads_warning:= $AdsWarning

onready var buttons := $CanvasLayer/Button
onready var pause_button := $CanvasLayer/Button/PauseButton
onready var play_button := $CanvasLayer/Button/PlayButton
onready var sfx_button := $CanvasLayer/Button/SFXButton
onready var music_button := $CanvasLayer/Button/MusicButton

onready var score_text := $CanvasLayer/HBoxContainer/Score
onready var wallet_text := $CanvasLayer/HBoxContainer/Wallet/Label
onready var multiplier_text := $CanvasLayer/HBoxContainer/Multiplier

onready var button_sfx := $ButtonSFX
onready var tween := $Tween


var score := 0 setget set_score
var wallet := 0 setget set_wallet

var is_fake_ads := true
var is_rewarded := false
var can_respawn := true

func _ready() -> void:
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("SFX")):
		sfx_button.set_pressed(true)
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Music")):
		music_button.set_pressed(true)
	
	connect("ads_warnig_triggered", ads_warning, "_on_ads_warning_triggered")
	connect("end_screen_triggered", end_screen, "_on_end_screen_triggered")
	
	ads_warning.get_close_button().connect(
		"pressed", self, "_on_AdsWarning_closed")
	
	if (UserData.ads and Engine.has_singleton("GodotAdMob")):
		admob.load_rewarded_video()
		is_fake_ads = false

func _on_score_updated(new_score : int) -> void:
	tween.interpolate_property(self, "score",
		score, new_score, (new_score - score)/1000.0,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_wallet_updated(new_wallet : int) -> void:
	tween.interpolate_property(self, "wallet",
		wallet, new_wallet, (new_wallet - wallet)/100.0,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_multiplier_updated(new_multiplier : int) -> void:
	if new_multiplier == 1:
		multiplier_text.set_text("")
		return
	multiplier_text.set_text("x%d" % new_multiplier)

func set_score(points : int) -> void:
	score = points
	score_text.set_text(str(score).pad_zeros(12))

func set_wallet(coins : int) -> void:
	wallet = coins
	wallet_text.set_text(str(wallet))

func _on_player_hitted() -> void:
	if can_respawn:
		for button in buttons.get_children():
			button.set_disabled(true)
		emit_signal("ads_warnig_triggered", Main.ads_reward_string[1])
		can_respawn = false
		return
	emit_signal("end_screen_triggered")

func _on_PauseButton_pressed():
	button_sfx.play()
	get_tree().set_pause(true)
	pause_screen.show()
	pause_button.set_visible(false)
	play_button.set_visible(true)

func _on_PlayButton_pressed():
	button_sfx.play()
	get_tree().set_pause(false)
	pause_screen.set_visible(false)
	play_button.set_visible(false)
	pause_button.set_visible(true)

func _on_SFXButton_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(
		AudioServer.get_bus_index("SFX"), button_pressed)
	button_sfx.play()

func _on_MusicButton_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(
		AudioServer.get_bus_index("Music"), button_pressed)
	button_sfx.play()

func _on_AdsWarning_confirmed() -> void:
	BackGroundMusic.set_stream_paused(true)
	
	if not (UserData.ads and Engine.has_singleton("GodotAdMob")):
		emit_signal("respawn_triggerd")
		return
	
	if not is_fake_ads:
		admob.show_rewarded_video()
		return
	
	fake_ads.show_ads(5)

func _on_AdsWarning_closed() -> void:
	emit_signal("end_screen_triggered")

func _on_FakeAds_closed() -> void:
	is_rewarded = true
	BackGroundMusic.set_stream_paused(false)
	emit_signal("respawn_triggerd")

func _on_AdMob_rewarded_video_loaded() -> void:
	is_fake_ads = false

func _on_AdMob_rewarded_video_failed_to_load(error_code : int) -> void:
	is_fake_ads = true

func _on_AdMob_rewarded(_currency : String, _ammount : int) -> void:
	is_rewarded = true
	BackGroundMusic.set_stream_paused(false)
	emit_signal("respawn_triggerd")

func _on_AdMob_rewarded_video_closed() -> void:
	is_fake_ads = true
	if not is_rewarded:
		admob.load_rewarded_video()
		emit_signal("ads_warnig_triggered", Main.ads_reward_string[1])
	
	BackGroundMusic.set_stream_paused(false)
