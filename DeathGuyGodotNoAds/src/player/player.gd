extends KinematicBody2D


signal on_player_hit()


onready var state_machine := $StateMachine
onready var head := $Head
onready var body := $Body
onready var collision_shape := $CollisionShape2D
onready var anim_play := $AnimationPlayer
onready var anim_tree := $AnimationTree
onready var inv_timeout := $Invincibility

export var acceleration := 24.0
export var max_speed := 8.0
export var max_rotation := PI/6
export var rot_acc := PI/2

var direction := 0.0
var linear_velocity := Vector2.ZERO
var collision : KinematicCollision2D
var invincibility := false


func _ready() -> void:
	yield(owner, "ready")
	head.set_texture(load(Data.head_dir + '/' + Data.head[UserData.last_head]))
	body.set_texture(load(Data.body_dir + '/' + Data.body[UserData.last_body]))
	set_modulate(Color(Data.color[UserData.last_color]))

func _on_Invincibility_timeout():
	invincibility = false
