extends PlayerState


func enter() -> void:
	yield(player.anim_play, "animation_finished")
	player.anim_play.play("fall")
	player.set_collision_mask_bit(0, true)

func physics_process(_delta: float) -> void:
	player.direction = get_direction()
	flip_body(player.direction)
	player.linear_velocity = calculate_velocity(player.max_speed, player.acceleration, player.direction, player.linear_velocity, player.global_position, _delta)
	player.rotation = calculate_rotation(player.max_rotation, player.rot_acc, player.direction, player.rotation, _delta)
	player.collision = player.move_and_collide(player.linear_velocity)
	if not player.invincibility and player.collision:
		emit_signal("change_state", "despawn")

func flip_body(direction : float) -> void:
	if direction > 0:
		player.head.flip_h = true
		player.body.flip_h = true
	elif direction < 0:
		player.head.flip_h = false
		player.body.flip_h = false

func calculate_velocity(
	max_speed : float, 
	acc : float,
	direction: float, 
	lv : Vector2,
	player_position : Vector2,
	delta : float
	) -> Vector2:
	
	if direction != 0:
		lv.x = clamp(lv.x + acc * delta * direction, -max_speed, max_speed)
	else:
		var abslv = abs(lv.x)
		abslv = max(abslv - acc * delta, 0)
		lv.x = sign(lv.x) * abslv
	
	if (player.position.x >= 752 and lv.x > 0):
		player.position.x = -32
	elif (player.position.x <= -32 and lv.x < 0):
		player.position.x = 752
	
	return lv

func calculate_rotation(
	max_rot : float,
	acc : float,
	direction : float,
	rotation : float,
	delta : float
	) -> float:
	
	if direction != 0:
		rotation = clamp(rotation + acc * delta * direction, -max_rot, max_rot)
		return rotation
	
	else:
		var absrot = abs(rotation)
		absrot = max(absrot - acc * delta, 0)
		rotation = sign(rotation) * absrot
	
	return rotation

func get_direction() -> float:
	if Main.os == "Android":
		var accelerometer = Input.get_accelerometer().x
		return clamp(accelerometer/2.0, -1.0, 1.0)
	return (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
