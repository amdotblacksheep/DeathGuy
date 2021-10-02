extends RGenState


var p_y := [0, 426, 853]
var last_x := 0
var min_distance := 148
var max_x := 720


func enter() -> void:
	randomize()
	last_x = randi() % max_x + 1

func physics_process(_delta: float) -> void:
	rgen.obj_velocity.y = clamp(rgen.obj_velocity.y + rgen.obj_gravity * _delta, -980.0, 0)

func generate() -> void:
	var x := last_x
	var direction = randi() % 2
	if direction == 0:
		direction = -1
	p_y.shuffle()
	
	for y in p_y:
		var distance : int = direction *((randi() % 32 + 1) + min_distance)
		var type := randi() % 20
		if type != 0:
			type = 1
		
		if x + distance > max_x:
			x += distance - max_x
		elif x + distance <= 0:
			x += max_x + distance
		else:
			x += distance
		
		var new_object : Node = rgen.object[type].instance()
		new_object.set_position(Vector2(x, y))
		new_object.velocity = rgen.obj_velocity
		rgen.add_child(new_object, true)
		
		if y == 0:
			new_object.connect("exit", rgen, "generate")
		
		
	last_x = x
