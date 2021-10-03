extends Element


func on_body_entered(_player : Player) -> void:
	sfx.play()
	collision_shape.call_deferred("set_disabled", true)
	tween.interpolate_property(sprite, "scale", Vector2(1, 1), 
		Vector2(0.5, 0.5), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.interpolate_property(sprite, "global_position", 
		sprite.get_global_position(), Vector2(640, 128), 0.5, 
		Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_all_completed")
	rgen.level.wallet += 10
	set_visible(false)
