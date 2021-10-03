extends KinematicBody2D
class_name Player


signal player_hitted()


onready var level = owner
onready var state_machine := $StateMachine
onready var collision_shape := $CollisionShape2D
onready var eraser_det := $EraserDetector

onready var sprites := $Sprites
onready var head := $Sprites/Head
onready var body := $Sprites/Body
onready var particles := $CPUParticles2D
onready var despawn_sfx := $DespawnSFX
onready var respawn_sfx := $RespawnSFX
onready var shield_sfx := $ShieldSFX

onready var resp_timeout := $RespawnTimer
onready var shield_timer := $ShieldTimer

onready var anim_player := $AnimationPlayer
onready var anim_tree := $AnimationTree

export var acceleration := 24.0
export var max_speed := 8.0
export var max_rotation := PI/6
export var rot_acc := PI/2

var collision : KinematicCollision2D
var last_eraser : Node

var direction := 0.0
var last_direction := 1.0
var linear_velocity := Vector2.ZERO

var is_respawning := false
var is_shielded := false
var is_despawning := false


func _ready() -> void:
	yield(level, "ready")
	head.set_texture(load(Data.head_dir + '/' + Data.head[UserData.last_head]))
	body.set_texture(load(Data.body_dir + '/' + Data.body[UserData.last_body]))
	sprites.set_modulate(Color(Data.color[UserData.last_color]))
	sprites.get_material().set_shader_param(
		"color", Data.shader_color[UserData.last_color])
	particles.set_color(Data.shader_color[UserData.last_color])

func _physics_process(delta: float) -> void:
	check_off_screen()
	particles.set_param(
		0, clamp(particles.get_param(0) + 2.0 * delta, 0.0, 200.0))
	if last_eraser != null:
		particles.set_direction(
			particles.get_global_position().direction_to(
				last_eraser.get_global_position()))

func check_off_screen() -> void:
	var player_position := get_global_position() 
	
	if (player_position.x > 738):
		set_global_position(Vector2(-48, player_position.y))
	elif (player_position.x < -48):
		set_global_position(Vector2(738, player_position.y))

func _on_Respawn_timeout() -> void:
	is_respawning = false


func _on_EraserDetector_area_entered(area: Area2D) -> void:
	if not is_respawning and area.is_in_group("Eraser"):
		last_eraser = area
		area.sfx.play()
		var bonus : int = (
			area.bonus_score * area.adj if area.adj != 0 
			else area.bonus_score)
		level.score += bonus * level.multiplier


func _on_EraserDetector_area_exited(area: Area2D) -> void:
	if area == last_eraser:
		last_eraser = null
		particles.set_direction(Vector2.UP)
		particles.set_lifetime(3.0)

func _on_ShieldTimer_timeout() -> void:
	is_shielded = false
