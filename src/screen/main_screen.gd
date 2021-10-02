extends Control


onready var player_sprite := $Sprite
onready var body_sprite := $Sprite/Body
onready var head_sprite := $Sprite/Head
onready var anim_play := $AnimationPlayer
onready var volume_button := $HBoxContainer/VolumeButton
onready var button_sfx:= $ButtonSFX


func _ready() -> void:
	SaveLoad.load_game()
	get_tree().set_pause(false)
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")):
		volume_button.set_pressed(true)
	body_sprite.set_texture(load(Data.body_dir + '/' +Data.body[UserData.last_body]))
	head_sprite.set_texture(load(Data.head_dir + '/' +Data.head[UserData.last_head]))
	player_sprite.set_modulate(Color(Data.color[UserData.last_color]))

func _on_PlayButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().change_scene_to(Main.level)

func _on_CustomizeButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().change_scene_to(Main.customization_screen)

func _on_VolumeButton_pressed() -> void:
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")):
		 AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)

func _on_ExitButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().quit()

func _on_EasterEgg_pressed() -> void:
	if anim_play.is_playing():
		return
	anim_play.play("sprite_unique")

func _on_ItchButton_pressed() -> void:
	button_sfx.play()
	yield(button_sfx, "finished")
	OS.shell_open("https://amdotblacksheep.itch.io/deathguy")

func _on_TwitterButton_pressed() -> void:
	button_sfx.play()
	yield(button_sfx, "finished")
	OS.shell_open("https://twitter.com/iamdeathguy")
