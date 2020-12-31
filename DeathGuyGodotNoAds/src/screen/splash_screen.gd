extends Control


onready var fake_ads := $FakeAds
onready var anim_play := $AnimationPlayer


func _ready() -> void:
	fake_ads.connect("fake_ads_closed", self, "_on_Fake_Ads_closed")
	yield(anim_play, "animation_finished")
	fake_ads.show_ads(5)

func _on_Fake_Ads_closed() -> void:
	get_tree().change_scene_to(Main.main_screen)
