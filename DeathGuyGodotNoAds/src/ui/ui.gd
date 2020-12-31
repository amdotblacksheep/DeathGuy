extends Control

signal set_pause(paused)

onready var pause_button := $PauseButton
onready var play_button := $PlayButton
onready var volume_button := $VolumeButton
onready var score := $Score
onready var coin := $Coin/Label
onready var button_sfx := $ButtonSFX
onready var anim_play := $AnimationPlayer

func _ready() -> void:
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")):
		volume_button.set_pressed(true)

func _on_UpdateScore(new_score : int) -> void:
	score.set_text(str(new_score))

func _on_UpdateCoin(new_coin : int) -> void:
	coin.set_text(str(new_coin))

func _on_PauseButton_pressed():
	button_sfx.play()
	get_tree().set_pause(true)
	pause_button.set_visible(false)
	play_button.set_visible(true)
	emit_signal("set_pause", true)

func _on_PlayButton_pressed():
	button_sfx.play()
	get_tree().set_pause(false)
	play_button.set_visible(false)
	pause_button.set_visible(true)
	emit_signal("set_pause", false)

func _on_VolumeButton_pressed() -> void:
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")):
		 AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
