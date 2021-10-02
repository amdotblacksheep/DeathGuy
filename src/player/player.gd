extends KinematicBody2D


signal on_player_hit()


onready var state_machine := $StateMachine
onready var sprites := $Sprites
onready var head := $Sprites/Head
onready var body := $Sprites/Body
onready var particles := $CPUParticles2D
onready var collision_shape := $CollisionShape2D
onready var tween := $Tween
onready var anim_play := $AnimationPlayer
onready var inv_timeout := $Invincibility

export var acceleration := 24.0
export var max_speed := 8.0
export var max_rotation := PI/6
export var rot_acc := PI/2

var direction := 0.0
var linear_velocity := Vector2.ZERO
var collision : KinematicCollision2D
var invincibility := false
var last_eraser : Node


func _ready() -> void:
	yield(owner, "ready")
	head.set_texture(load(Data.head_dir + '/' + Data.head[UserData.last_head]))
	body.set_texture(load(Data.body_dir + '/' + Data.body[UserData.last_body]))
	sprites.set_modulate(Color(Data.color[UserData.last_color]))
	sprites.material.set_shader_param("color", Data.shader_color[UserData.last_color])
	particles.set_color(Data.shader_color[UserData.last_color])

func _physics_process(delta: float) -> void:
	particles.set_param(0, clamp(particles.get_param(0) + 9.8 * delta, 0.0, 980.0))
	if last_eraser != null:
		particles.set_direction(particles.get_global_position().direction_to(last_eraser.get_global_position()))
		particles.set_lifetime(0.1)


func _on_Invincibility_timeout():
	invincibility = false

func _on_EraserDetector_body_entered(body: Node) -> void:
	if not invincibility:
		last_eraser = body
		body.sfx.play()
		var bonus : int = body.bonus_score * body.adj if body.adj != 0 else body.bonus_score
		tween.interpolate_property(get_parent(), "score", get_parent().score, get_parent().score + bonus, 1.0/bonus, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
#		get_parent().score = body.bonus_score * body.adj if body.adj != 0 else body.bonus_score

func _on_EraserDetector_body_exited(body: Node) -> void:
	if body == last_eraser:
		last_eraser = null
		particles.set_direction(Vector2.UP)
		particles.set_lifetime(3.0)
