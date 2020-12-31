extends PlayerState


func enter() -> void:
	player.set_collision_mask_bit(0, false)
	player.linear_velocity = Vector2.ZERO
	player.anim_play.play("despawn")
	yield(player.anim_play, "animation_finished")
	player.emit_signal("on_player_hit")
