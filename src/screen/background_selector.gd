extends Control

signal show_unlock()

onready var background_texture := $Background
onready var anim_play := $AnimationPlayer
onready var unlock_button := $HBoxContainer/UnlockButton
onready var button_sfx := $ButtonSFX

var background : int = UserData.last_background
var cost : int = 500


func _ready():
	yield(get_parent(), "ready")
	connect("show_unlock", get_parent().unlock_screen, "_on_ShowUnlock")
	background_texture.texture = load(Data.back_dir + '/' + Data.background[background])

func _on_LeftButton_pressed():
	button_sfx.play()
	background -= 1
	if background < 0:
		background = Data.background.size() - 1
	background_texture.get_material().set_shader_param("next", load(Data.back_dir + '/' + Data.background[background]))
	anim_play.play("change_left")
	if background in UserData.unlocked_background:
		unlock_button.disabled = true
		UserData.last_background = background
		SaveLoad.save_game()
	else:
		unlock_button.disabled = false
	yield(anim_play, "animation_finished")
	background_texture.texture = load(Data.back_dir + '/' + Data.background[background])

func _on_RightButton_pressed():
	button_sfx.play()
	background += 1
	if background >= Data.background.size():
		background = 0
	background_texture.get_material().set_shader_param("next", load(Data.back_dir + '/' + Data.background[background]))
	anim_play.play("change_right")
	if background in UserData.unlocked_background:
		unlock_button.disabled = true
		UserData.last_background = background
		SaveLoad.save_game()
	else:
		unlock_button.disabled = false
	yield(anim_play, "animation_finished")
	background_texture.texture = load(Data.back_dir + '/' + Data.background[background])

func _on_UnlockButton_pressed():
	button_sfx.play()
	emit_signal("show_unlock", self, "_on_UnlockedBackground", background, cost)

func _on_UnlockedBackground(index : int) -> void:
	unlock_button.set_disabled(true)
	UserData.unlocked_background.append(index)
	UserData.last_background = background
	UserData.wallet -= cost
	get_parent().coin.set_text(str(UserData.wallet))
	SaveLoad.save_game()
