extends RGenState


export var element_y := [0, 426, 853]
export var min_distance := 148
export var max_x := 720

var last_x := 0


func enter() -> void:
	randomize()
	last_x = randi() % (max_x + 1)

func physics_update(_delta: float) -> void:
	rgen.velocity.y = clamp(rgen.velocity.y + rgen.gravity * _delta, -800.0, 0)

func generate() -> void:
	var direction := randi() % 2
	if direction == 0:
		direction = -1
	
	var y := element_y.duplicate(true)
	last_x = new_generation(last_x, y, direction)

func new_generation(x : int, y : Array, dir : int) -> int:
	if (y.size() == 0):
		return x
	randomize()
	var distance : int = dir * ((randi() % 32 + 1) + min_distance)
	
	var element : PackedScene = rgen.get_wrandom_element(randf(), 0)
	
	x = check_off_screen(x, distance, max_x)
	
	var new_element := add_element(x, y[0], element)
	if (y[0] == 0):
		new_element.trigger_pos = 0
		new_element.connect("next_triggered", rgen, "generate")
	
	y.remove(0)
	
	return new_generation(x, y, dir)
