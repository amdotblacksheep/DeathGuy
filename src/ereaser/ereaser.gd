extends StaticBody2D


signal exit()
signal sniper()
signal burst()


onready var sfx := $AudioStreamPlayer

var velocity := Vector2.ZERO
var gravity := -9.8
var bonus_score := 10
var adj := 0


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
	velocity.y = clamp(velocity.y + gravity * delta, -980.0, 0.0)
	translate(velocity * delta)
	adj = int( -(velocity.y - 20.0) / 100.0 )
