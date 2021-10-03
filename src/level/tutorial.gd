extends Node2D

signal score_updated(new_score)
signal wallet_updated(new_wallet)
signal multiplier_updated(new_multiplier)
signal update_tutorial()

onready var player := $Player
onready var rand_gen := $RandomGenerator

onready var background := $ParallaxBackground
onready var gui := $CanvasLayer/GUI

onready var mult_timer := $MultiplierTimer

onready var tween := $Tween
onready var anim_play := $AnimationPlayer

onready var tutorial_screen := $CanvasLayer/TutorialScreen

onready var raycast := $RayCast2D

var score := 0 setget set_score
var wallet := 0 setget set_wallet
var multiplier := 1 setget set_multiplier


func _ready() -> void:
	get_tree().set_pause(false)
	
	BackGroundMusic.set_stream(
		load(Data.levelm_dir + '/' + Data.levelmusic[0]))
	BackGroundMusic.play()
	
	connect("score_updated", gui, "_on_score_updated")
	connect("wallet_updated", gui, "_on_wallet_updated")
	connect("multiplier_updated", gui, "_on_multiplier_updated")
	connect("update_tutorial", tutorial_screen, "_on_UpdateTutorial")
	
	player.connect("player_hitted", self, "_on_player_hitted")
	rand_gen.connect("state_changed", self, "_on_state_changed")

func _physics_process(delta: float) -> void:
	background.parallax.motion_offset.x = clamp(background.parallax.motion_offset.x - player.linear_velocity.x / 10, -1080, 1080)
	
	if not raycast.is_enabled():
		return
	
	raycast.force_raycast_update()
	if raycast.is_colliding():
		emit_signal("update_tutorial")
		raycast.set_enabled(false)

func set_score(points : int) -> void:
	score = points
	emit_signal("score_updated", score)

func set_wallet(coins : int) -> void:
	wallet = coins
	emit_signal("wallet_updated", wallet)

func set_multiplier(new_mult : int) -> void:
	if new_mult <= 8:
		multiplier = new_mult
		emit_signal("multiplier_updated", multiplier)
	mult_timer.start()

func _on_player_hitted() -> void:
	get_tree().set_pause(true)
	
	if UserData.score_record < int(score):
		UserData.score_record = int(score)
	UserData.wallet += wallet + score/100  
	
	SaveLoad.save_game()
	
	emit_signal("update_tutorial")

func _on_state_changed() -> void:
	anim_play.play("glitch")
	if tutorial_screen.phase == 0:
		yield(anim_play, "animation_finished")
		emit_signal("update_tutorial")

func _on_MultiplierTimer_timeout() -> void:
	multiplier = 1
	emit_signal("multiplier_updated", multiplier)
