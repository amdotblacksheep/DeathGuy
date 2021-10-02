extends Area2D

signal exit()

onready var collision_shape := $CollisionShape2D
onready var tween := $Tween
onready var sprite := $Sprite
onready var sfx := $AudioStreamPlayer

var velocity := Vector2.ZERO
var _gravity := -9.8

func _ready() -> void:
	connect("exit", get_parent(), "_on_ObjectExit")

func _physics_process(delta: float) -> void:
	if global_position.y <= 0:
		call_deferred("queue_free")
		emit_signal("exit")
	velocity.y = clamp(velocity.y + _gravity * delta, -1000.0, 0.0)
	translate(velocity * delta)

func _on_body_entered(_body: Node) -> void:
	sfx.play()
	collision_shape.call_deferred("set_disabled", true)
	get_parent().level.coin = 10
	tween.interpolate_property(sprite, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	set_visible(false)
