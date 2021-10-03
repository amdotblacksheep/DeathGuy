extends PlayerState


func enter() -> void:
	player.eraser_det.set_collision_mask_bit(0, true)

func physics_update(_delta: float) -> void:
	player.direction = get_direction()
	player.last_direction = (player.direction if player.direction != 0 
							else player.last_direction)
	flip_body(player.direction)
	
	player.linear_velocity = calculate_velocity(
		player.max_speed, player.acceleration, 
		player.direction, player.linear_velocity,
		 _delta)
	
	player.rotation = calculate_rotation(player.max_rotation, player.rot_acc, 
	player.direction, player.rotation, 
	_delta)
	
	player.collision = player.move_and_collide(player.linear_velocity)

func flip_body(direction : float) -> void:
	if direction > 0.1:
		player.head.flip_h = true
		player.body.flip_h = true
	
	elif direction < -0.1:
		player.head.flip_h = false
		player.body.flip_h = false

func calculate_velocity(
	max_speed : float, 
	acc : float,
	direction: float, 
	lv : Vector2,
	delta : float
	) -> Vector2:
	
	if direction != 0:
		lv.x = clamp(lv.x + acc * delta * direction, -max_speed, max_speed)
		return lv
	
	var abslv = abs(lv.x)
	abslv = max(abslv - acc/2.0 * delta, 0)
	lv.x = sign(lv.x) * abslv
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
	
	var absrot = abs(rotation)
	absrot = max(absrot - acc/2.0 * delta, 0)
	rotation = sign(rotation) * absrot
	return rotation

func get_direction() -> float:
	if Main.os == "Android":
		var accelerometer = Input.get_accelerometer().x
		return clamp(accelerometer/2.0, -1.0, 1.0)
	
	return (Input.get_action_strength("move_right") - 
			Input.get_action_strength("move_left"))
