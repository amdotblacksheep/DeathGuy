extends RigidBody2D

signal erased()

onready var sprites := $Sprites
onready var head := $Sprites/Head
onready var body := $Sprites/Body
onready var particles := $CPUParticles2D
onready var collision_shape := $CollisionShape2D
onready var anim_play := $AnimationPlayer
onready var despawn_sfx := $DespawnSFX

var standard_position := Vector2(0, -32)
var standard_extents := Vector2(32, 32)
var standard_scale := Vector2(1, 1)
var standard_p_position := Vector2(0, -20)
var standar_s_amount := 2
var p_scale : Array = [0.5, 1, 2]

func _ready() -> void:
	randomize()
	random_guy()
	anim_play.play("fall")

func random_guy() -> void:
	var random_head : int = randi() % Data.head.size()
	var random_color : int = randi() % Data.color.size()
	var random_p : int = randi() % p_scale.size()
	var random_scale : float = p_scale[random_p]
	var random_flip : bool = randi() % 2
	
	set_z_index(random_p)
	head.set_texture(load(Data.head_dir + '/' + Data.head[random_head]))
#	body.set_texture(load(Data.body_dir + '/' + Data.body[UserData.last_body]))
	head.set_flip_h(random_flip)
	body.set_flip_h(random_flip)
	sprites.set_modulate(Color(Data.color[random_color]))
	sprites.get_material().set_shader_param(
		"color", Data.shader_color[random_color])
	particles.set_color(Data.shader_color[random_color])
	
	sprites.set_scale(standard_scale * random_scale)
	particles.set_scale(standard_scale * random_scale * 2)
	particles.set_param(8, standar_s_amount * random_scale * 2)
	sprites.set_position(standard_position * random_scale)
	particles.set_position(standard_p_position * random_scale)
	collision_shape.set_position(standard_position * random_scale)
	set_gravity_scale(random_scale)

func _physics_process(delta: float) -> void:
	if global_position.y > 1600:
		call_deferred("queue_free")

func _on_FallGuy_input_event(
	viewport: Node, 
	event: InputEvent, 
	shape_idx: int
	) -> void:
	
	if event.is_action_type():
		set_pickable(false)
		anim_play.play("despawn")
		despawn_sfx.play()
		yield(anim_play, "animation_finished")
		emit_signal("erased")

func _on_FallGuy_mouse_entered() -> void:
	Input.set_default_cursor_shape(3)

func _on_FallGuy_mouse_exited() -> void:
	Input.set_default_cursor_shape(0)

func _on_EEGame_hidden_activeted() -> void:
	set_pickable(false)
