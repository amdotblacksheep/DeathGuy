extends Node2D

signal update_score(score)
signal update_coin(coin)
signal update_record(new_record)


onready var player := $Player
onready var rand_gen := $RandomGenerator
onready var background := $ParallaxBackground
onready var ui := $CanvasLayer/UI
onready var end_screen := $CanvasLayer/EndScreen
onready var pause_screen := $CanvasLayer/PauseScreen
onready var tween := $Tween
onready var anim_play := $AnimationPlayer

var score := 0 setget set_score
var coin := 0 setget set_coin


func _ready() -> void:
	get_tree().set_pause(false)
	BackGroundMusic.set_stream(load(Data.levelm_dir + '/' + Data.levelmusic[0]))
	BackGroundMusic.play()
	connect("update_score", ui, "_on_UpdateScore")
	connect("update_coin", ui, "_on_UpdateCoin")
	connect("update_record", end_screen, "_on_UpdateRecord")
	player.connect("on_player_hit", self, "_on_PlayerHit")
	rand_gen.connect("next_gen", self, "_on_NextGen")
	ui.connect("set_pause", pause_screen, "_on_SetPause")
	end_screen.connect("second_chance", self, "_on_SecondChance")
	yield(anim_play, "animation_finished")

func _physics_process(delta: float) -> void:
	background.parallax.motion_offset.x = clamp(background.parallax.motion_offset.x - player.linear_velocity.x / 10, -1080, 1080)

func set_score(points : int) -> void:
	score = points
	emit_signal("update_score", score)

func set_coin(number : int) -> void:
	coin = number
	emit_signal("update_coin", coin)

func _on_PlayerHit() -> void:
	get_tree().set_pause(true)
	ui.anim_play.play("end_anim")
	end_screen.anim_play.play("end_anim")
	if UserData.score_record < int(score):
		UserData.score_record = int(score)
	emit_signal("update_record", UserData.score_record)
	SaveLoad.save_game()

func _on_NextGen() -> void:
	anim_play.play("glitch")

func _on_SecondChance() -> void:
	get_tree().set_pause(false)
	end_screen.set_visible(false)
	ui.anim_play.play("RESET")
	player.state_machine.state.emit_signal("change_state", "respawn")
