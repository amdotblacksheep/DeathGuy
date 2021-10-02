extends RGenState


var p_y := [0, 64, 128]
var p_x := [-96, 96, 0]
var max_x := 720


func enter() -> void:
	randomize()

func physics_process(_delta: float) -> void:
	rgen.obj_velocity.y = clamp(rgen.obj_velocity.y + rgen.obj_gravity * _delta, -980.0, 0)

func generate() -> void:
	var x : float = rgen.level.player.get_global_position().x
	var distance : int = sign(rgen.level.player.direction) * (96)
	
	if distance != 0:
		for n_y in p_y:
			var type := randi() % 20
			if type != 0:
				type = 1
			
			var new_object : Node = rgen.object[type].instance()
			new_object.set_position(Vector2(x, n_y))
			new_object.velocity = rgen.obj_velocity
			rgen.add_child(new_object, true)
			
			if n_y == 0:
				new_object.connect("burst", rgen, "generate")
			
			if x + distance > max_x:
				x += distance - max_x
			elif x + distance <= 0:
				x += max_x + distance
			else:
				x += distance
	
	else:
		var last_obj : Node
		for n_x in p_x:
			var n_y := 64 if n_x != 0 else 0
			var type := randi() % 20
			if type != 0:
				type = 1
			
			if n_x + x > max_x:
				n_x += x - max_x
			elif n_x + x <= 0:
				n_x += max_x + x
			else:
				n_x += x
			
			var new_object : Node = rgen.object[type].instance()
			new_object.set_position(Vector2(n_x, n_y))
			new_object.velocity = rgen.obj_velocity
			rgen.add_child(new_object, true)
			last_obj = new_object
			
		last_obj.connect("burst", rgen, "generate")
