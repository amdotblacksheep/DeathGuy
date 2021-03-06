extends Control


onready var admob := $AdMob
onready var admob_debugger := $CanvasLayer/AdMobDebug
onready var fake_ads := $FakeAds
onready var anim_play := $AnimationPlayer

var is_fake_ads := true


func _ready() -> void:
	fake_ads.connect("fake_ads_closed", self, "_on_Fake_Ads_closed")
	
	if not (Engine.has_singleton("GodotAdMob")):
#		admob_debugger.label.set_text("AdMob Java Singleton not found. This plugin will only work on Android.")
		yield(anim_play, "animation_finished")
		fake_ads.show_ads(5)
	
	admob.load_interstitial()
	yield(anim_play, "animation_finished")
	if is_fake_ads:
		fake_ads.show_ads(5)
	else:
		admob.show_interstitial()

func _on_Fake_Ads_closed() -> void:
	get_tree().change_scene_to(Main.main_screen)

func _on_AdMob_interstitial_closed() -> void:
#	admob_debugger.label.set_text("Interstistial ad closed.")
	get_tree().change_scene_to(Main.main_screen)

func _on_AdMob_interstitial_loaded() -> void:
	is_fake_ads = false

func _on_AdMob_interstitial_failed_to_load(error_code : int) -> void:
#	admob_debugger.label.set_text("Interstistial ad failed to load with error : %d." % error_code)
	if anim_play.is_playing():
		yield(anim_play, "animation_finished")
	fake_ads.show_ads(5)
