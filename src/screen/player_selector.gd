extends HBoxContainer

signal unlock_pressed()

onready var body_sprite := $Sprites/Body
onready var head_sprite := $Sprites/Head
onready var player_sprite := $Sprites
onready var unlock_button := $Sprites/UnlockButton
onready var button_sfx := $ButtonSFX
onready var anim_play := $AnimationPlayer

var body : int = UserData.last_body
var head : int = UserData.last_head
var cost := 1500

func _ready() -> void:
	yield(owner, "ready")
	
	body_sprite.set_texture(load(Data.body_dir + '/' + Data.body[body]))
	head_sprite.set_texture(load(Data.head_dir + '/' + Data.head[head]))
	body_sprite.set_modulate(Color(Data.color[UserData.last_color]))
	head_sprite.set_modulate(Color(Data.color[UserData.last_color]))
	player_sprite.get_material().set_shader_param(
		"color", Data.shader_color[UserData.last_color])

func _on_LeftButton_pressed() -> void:
	button_sfx.play()
	anim_play.play("change_left")
	yield(anim_play, "animation_finished")
	
	anim_play.play("player_anim")

func _on_RightButton_pressed() -> void:
	button_sfx.play()
	anim_play.play("change_right")
	yield(anim_play, "animation_finished")
	
	anim_play.play("player_anim")

func _on_UnlockButton_pressed():
	button_sfx.play()
	emit_signal("unlock_pressed", self, "_on_head_unlocked", head, cost)

func change_sprite(new_head : int) -> void:
	head += new_head
	if head >= Data.head.size():
		head = 0
	elif head < 0:
		head = Data.head.size() - 1
	
	head_sprite.set_texture(load(Data.head_dir + '/' + Data.head[head]))
	
	if head in UserData.unlocked_head:
		unlock_button.set_disabled(true)
		unlock_button.set_visible(false)
		UserData.last_head = head
	else:
		unlock_button.set_disabled(false)
		unlock_button.set_visible(true)
	
	SaveLoad.save_game()

func _on_player_color_changed(new_color : int) -> void:
	body_sprite.modulate = Color(Data.color[new_color])
	head_sprite.modulate = Color(Data.color[new_color])
	player_sprite.material.set_shader_param(
		"color", Data.shader_color[new_color])

func _on_head_unlocked(index : int) -> void:
	unlock_button.set_disabled(true)
	unlock_button.set_visible(false)
	
	UserData.unlocked_head.append(index)
	UserData.last_head = head
	UserData.wallet -= cost
	
	get_parent().coin.set_text(str(UserData.wallet))
	
	SaveLoad.save_game()
