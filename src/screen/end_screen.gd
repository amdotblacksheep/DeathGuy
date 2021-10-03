extends Control


onready var score_text := $Score
onready var wallet_text := $Wallet/Label
onready var record_text := $Record

onready var button_sfx := $ButtonSFX
onready var tween := $Tween
onready var anim_play := $AnimationPlayer

var score := 0 setget set_score
var wallet := 0 setget set_wallet
var record := 0 setget set_record


func _ready() -> void:
	record = UserData.score_record
	record_text.set_text("Your record: %012d" % record)

func _on_end_screen_triggered() -> void:
	anim_play.play("show")
	yield(anim_play, "animation_finished")
	
	tween.interpolate_property(self, "score",
		0, get_parent().get_parent().score, 1.0,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "wallet",
		0, get_parent().get_parent().wallet, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	
	tween.interpolate_property(self, "wallet",
	wallet, wallet + (score/100), 1.0, 
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	
	if score > record:
		tween.interpolate_property(self, "record",
			record, score, 0.5,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	yield(tween, "tween_all_completed")

func _on_RetryButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	anim_play.play("exit")
	yield(anim_play, "animation_finished")
	get_tree().reload_current_scene()

func _on_CustomizeButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	anim_play.play("exit")
	yield(anim_play, "animation_finished")
	BackGroundMusic.stop()
	get_tree().change_scene_to(Main.customization_screen)

func _on_LeaderButton_pressed() -> void:
	pass # Replace with function body.

func _on_ExitButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	anim_play.play("exit")
	yield(anim_play, "animation_finished")
	BackGroundMusic.stop()
	get_tree().change_scene_to(Main.main_screen)

func set_score(points : int) -> void:
	score = points
	score_text.set_text(str(score).pad_zeros(12))

func set_wallet(coins : int) -> void:
	wallet = coins
	wallet_text.set_text(str(wallet))

func set_record(points : int) -> void:
	record = points
	record_text.set_text("Your record: %012d" % record)
