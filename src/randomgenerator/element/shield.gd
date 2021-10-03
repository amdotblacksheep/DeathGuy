extends Element

func on_body_entered(player : Player) -> void:
	sfx.play()
	collision_shape.call_deferred("set_disabled", true)
	tween.interpolate_property(sprite, "scale", Vector2(1, 1), 
		Vector2(2.0, 2.0), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.interpolate_property(sprite, "global_position", 
		sprite.get_global_position(), player.get_global_position(), 0.5, 
		Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
	if not player.is_shielded or not player.shield_timer.is_stopped():
		player.shield_timer.stop()
		player.is_shielded = true
		player.anim_tree["parameters/playback"].travel("shielded")
	yield(tween, "tween_all_completed")
	set_visible(false)
