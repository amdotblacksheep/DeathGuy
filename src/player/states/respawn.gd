extends PlayerState


func enter() -> void:
	player.is_despawning = false
	player.is_respawning = true
	player.linear_velocity = Vector2.ZERO
	player.resp_timeout.start()
	player.anim_tree["parameters/playback"].travel("respawn")
	player.respawn_sfx.play()
	
	state_machine.transition_to("Fall")
