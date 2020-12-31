extends StaticBody2D


signal exit()


onready var sfx := $AudioStreamPlayer

var velocity := Vector2.ZERO
var gravity := -9.8
var bonus_score := 10


func _ready() -> void:
	connect("exit", get_parent(), "_on_ObjectExit")
	if velocity.y < -700.0:
		bonus_score = 100
	elif velocity.y < -400.0:
		bonus_score = 50

func _physics_process(delta: float) -> void:
	if global_position.y <= 0:
		call_deferred("queue_free")
		emit_signal("exit")
	velocity.y = clamp(velocity.y + gravity * delta, -980.0, 0.0)
	translate(velocity * delta)

func _on_BonusArea_body_entered(body: Node) -> void:
	if not body.invincibility:
		sfx.play()
		get_parent().level.score = bonus_score
