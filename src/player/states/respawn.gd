extends PlayerState


func enter() -> void:
	player.invincibility = true
	player.linear_velocity = Vector2.ZERO
	player.anim_play.play("respawn")
	player.inv_timeout.start()
	emit_signal("change_state", "fall")
