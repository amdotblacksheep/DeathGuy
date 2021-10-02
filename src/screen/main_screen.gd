extends Control


signal show_ee()


onready var player_sprite := $Sprites
onready var body_sprite := $Sprites/Body
onready var head_sprite := $Sprites/Head
onready var anim_play := $AnimationPlayer
onready var volume_button := $HBoxContainer/VolumeButton
onready var music_button := $HBoxContainer/MusicButton
onready var ee_message := $EasterEggMessage
onready var button_sfx := $ButtonSFX


func _ready() -> void:
	SaveLoad.load_game()
	get_tree().set_pause(false)
	if not BackGroundMusic.is_playing():
		BackGroundMusic.set_stream(load(Data.menum_dir + '/' + Data.menumusic[0]))
		BackGroundMusic.play()
	connect("show_ee", ee_message, "_on_ShowEE")
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("SFX")):
		volume_button.set_pressed(true)
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Music")):
		music_button.set_pressed(true)
	body_sprite.set_texture(load(Data.body_dir + '/' + Data.body[UserData.last_body]))
	head_sprite.set_texture(load(Data.head_dir + '/' + Data.head[UserData.last_head]))
	player_sprite.set_modulate(Color(Data.color[UserData.last_color]))
	player_sprite.material.set_shader_param("color", Data.shader_color[UserData.last_color])

func _on_PlayButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().change_scene_to(Main.level)

func _on_TutorialButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().change_scene_to(Main.tutorial)

func _on_CustomizeButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().change_scene_to(Main.customization_screen)

func _on_VolumeButton_pressed() -> void:
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("SFX")):
		 AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), false)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), true)

func _on_MusicButton_pressed() -> void:
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Music")):
		 AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)

func _on_ExitButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	yield(button_sfx, "finished")
	get_tree().quit()

func _on_EasterEgg_pressed() -> void:
	if anim_play.is_playing():
		return
	anim_play.play("sprite_unique")
	yield(anim_play, "animation_finished")
	emit_signal("show_ee")
	anim_play.play("reset_sprite")

func _on_ItchButton_pressed() -> void:
	button_sfx.play()
	yield(button_sfx, "finished")
	OS.shell_open("https://amdotblacksheep.itch.io/deathguy")

func _on_TwitterButton_pressed() -> void:
	button_sfx.play()
	yield(button_sfx, "finished")
	OS.shell_open("https://twitter.com/iamdeathguy")

