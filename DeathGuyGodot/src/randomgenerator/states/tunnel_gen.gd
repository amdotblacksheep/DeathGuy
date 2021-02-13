extends RGenState

var direction := 1
var last_x = 0
var first = true

func enter() -> void:
	first = true
	last_x = 0
	randomize()
	direction = randi() % 2
	if direction == 0:
		direction = -1

func physics_process(_delta: float) -> void:
	rgen.obj_velocity.y = clamp(rgen.obj_velocity.y + rgen.obj_gravity * _delta, -980.0, 0)

func generate() -> void:
	if first:
		var obj_position := [Vector2(last_x, 0), Vector2(720 - last_x, 0)]
		last_x = phase_1(obj_position)
		first = false
		return
	var obj_position := [Vector2(last_x, 0), Vector2(480 + last_x, 0)]
	last_x = phase_2(obj_position)

func phase_1(obj_position : Array) -> int:
	for j in 10:
		var new_object : Node
		for i in obj_position:
			new_object = rgen.object[1].instance()
			new_object.set_position(i)
			new_object.velocity = rgen.obj_velocity
			rgen.add_child(new_object, true)
		if j == 0:
			new_object.connect("exit", rgen, "generate")

		var type := randi() % 20
		if type == 0:
			new_object = rgen.object[0].instance()
			new_object.set_position(Vector2(360, obj_position[0].y))
			new_object.velocity = rgen.obj_velocity
			rgen.add_child(new_object, true)
	
		if obj_position[0].x < 128:
			obj_position[0].x += 16
		obj_position[0].y += 128
		obj_position[1] = Vector2(720 - obj_position[0].x, obj_position[0].y)
	return obj_position[0].x

func phase_2(obj_position : Array) -> int:
	
	var new_object : Node
	
	for j in 10:
		for i in obj_position:
			new_object = rgen.object[1].instance()
			new_object.set_position(i)
			new_object.velocity = rgen.obj_velocity
			rgen.add_child(new_object, true)
		if j == 0:
			new_object.connect("exit", rgen, "generate")
		
		var type := randi() % 20
		if type == 0:
			new_object = rgen.object[0].instance()
			new_object.set_position(Vector2(obj_position[0].x + 240, obj_position[0].y))
			new_object.velocity = rgen.obj_velocity
			rgen.add_child(new_object, true)
		
		obj_position[0] += Vector2(16 * direction, 128)
		obj_position[1] = Vector2(480, 0) + obj_position[0]
		
		if obj_position[0].x > 368:
			direction = -1
		elif obj_position[0].x < -128:
			direction = 1
	return obj_position[0].x
