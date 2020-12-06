extends PlayerState


func enter() -> void:
	player.collision_shape.call_deferred("set_disabled", true)
	player.linear_velocity = Vector2.ZERO
	player.anim_play.play("despawn")
	yield(player.anim_play, "animation_finished")
	player.emit_signal("on_player_hit")
