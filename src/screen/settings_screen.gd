extends PopupPanel

onready var master_value := $Control/VBoxContainer/HBoxContainer/MasterHSlider
onready var sfx_value := $Control/VBoxContainer/HBoxContainer2/SFXHSlider
onready var music_value := $Control/VBoxContainer/HBoxContainer3/MusicHSlider
onready var master_label := $Control/VBoxContainer/HBoxContainer/Value
onready var sfx_label := $Control/VBoxContainer/HBoxContainer2/Value
onready var music_label := $Control/VBoxContainer/HBoxContainer3/Value
onready var ads_button := $Control/AdsCheckButton

onready var button_sfx := $ButtonSFX


var array := [-72, -64, -56, -48, -40, -32, -24, -16, -8, 0]

func _ready() -> void:
	yield(owner, "ready")
	master_value.set_value(UserData.bus["master"])
	sfx_value.set_value(UserData.bus["sfx"])
	music_value.set_value(UserData.bus["music"])
	master_label.set_text(str(UserData.bus["master"]).pad_zeros(2))
	sfx_label.set_text(str(UserData.bus["sfx"]).pad_zeros(2))
	music_label.set_text(str(UserData.bus["music"]).pad_zeros(2))
	if not Engine.has_singleton("GodotAdMob"):
		ads_button.set_disabled(true)
		UserData.ads = false
	ads_button.set_pressed(UserData.ads)
	button_sfx.set_stream_paused(false)

func _on_MasterHSlider_value_changed(value: int) -> void:
	AudioServer.set_bus_volume_db(0, array[value])
	master_label.set_text(str(value).pad_zeros(2))
	if not button_sfx.get_stream_paused():
		button_sfx.play()
	UserData.bus["master"] = value

func _on_SFXHSlider_value_changed(value: int) -> void:
	AudioServer.set_bus_volume_db(1, array[value])
	sfx_label.set_text(str(value).pad_zeros(2))
	if not button_sfx.get_stream_paused():
		button_sfx.play()
	UserData.bus["sfx"] = value

func _on_MusicHSlider_value_changed(value: int) -> void:
	AudioServer.set_bus_volume_db(2, array[value])
	music_label.set_text(str(value).pad_zeros(2))
	if not button_sfx.get_stream_paused():
		button_sfx.play()
	UserData.bus["music"] = value

func _on_AdsCheckButton_toggled(button_pressed: bool) -> void:
	if not button_sfx.get_stream_paused():
		button_sfx.play()
	UserData.ads = button_pressed

func _on_CalibrateButton_pressed() -> void:
	pass # Replace with function body.

func _on_CloseButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	set_visible(false)
