extends Area2D

signal exit()
signal sniper()
signal burst()

onready var collision_shape := $CollisionShape2D
onready var tween := $Tween
onready var sprite := $Sprite
onready var sfx := $AudioStreamPlayer

var velocity := Vector2.ZERO
var _gravity := -9.8

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if get_signal_connection_list("sniper").size() != 0 and global_position.y <= 640:
		emit_signal("sniper")
		disconnect("sniper", get_parent(), "generate")
	if get_signal_connection_list("burst").size() != 0 and global_position.y <= 320:
		emit_signal("burst")
		disconnect("burst", get_parent(), "generate")
	if global_position.y <= 0:
		emit_signal("exit")
		get_parent().level.score += 1
		call_deferred("queue_free")
	velocity.y = clamp(velocity.y + _gravity * delta, -1000.0, 0.0)
	translate(velocity * delta)

func _on_body_entered(_body: Node) -> void:
	sfx.play()
	collision_shape.call_deferred("set_disabled", true)
	tween.interpolate_property(get_parent().level, "coin", get_parent().level.coin, get_parent().level.coin + 10, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(sprite, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	set_visible(false)
