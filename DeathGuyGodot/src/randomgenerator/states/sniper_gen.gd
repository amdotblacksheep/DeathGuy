extends RGenState


func enter() -> void:
	randomize()

func physics_process(_delta: float) -> void:
	rgen.obj_velocity.y = clamp(rgen.obj_velocity.y + rgen.obj_gravity * _delta, -980.0, 0)

func generate() -> void:
	var x_position : float = rgen.level.player.get_global_position().x
	var type := randi() % 20
	if type != 0:
		type = 1
	var new_object : Node = rgen.object[type].instance()
	new_object.set_position(Vector2(x_position, 0))
	new_object.velocity = rgen.obj_velocity
	rgen.add_child(new_object, true)
	new_object.connect("sniper", rgen, "generate")
