extends Control


onready var admob := $AdMob
onready var admob_debugger := $CanvasLayer/AdMobDebug
onready var anim_play := $AnimationPlayer



func _ready() -> void:
	if not (Engine.has_singleton("GodotAdMob")):
		admob_debugger.label.set_text("AdMob Java Singleton not found. This plugin will only work on Android.")
		yield(anim_play, "animation_finished")
		get_tree().change_scene_to(Main.main_screen)
	admob.load_interstitial()


func _on_AdMob_interstitial_closed() -> void:
	admob_debugger.label.set_text("Interstistial ad closed.")
	get_tree().change_scene_to(Main.main_screen)

func _on_AdMob_interstitial_loaded() -> void:
	admob_debugger.label.set_text("Interstistial ad loaded.")
	if anim_play.is_playing():
		yield(anim_play, "animation_finished")
	admob.show_interstitial()

func _on_AdMob_interstitial_failed_to_load(error_code : int) -> void:
	admob_debugger.label.set_text("Interstistial ad failed to load with error : %d." % error_code)
	if anim_play.is_playing():
		yield(anim_play, "animation_finished")
	get_tree().change_scene_to(Main.main_screen)
