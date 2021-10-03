extends RGenState

var max_y := 1280
var max_x := 720
var last_x := 128
var direction := 0

var is_just_entered := true

func enter() -> void:
	randomize()
	direction = randi() % 2
	if direction == 0:
		direction = -1
	last_x = 128
	is_just_entered = true

func physics_update(_delta: float) -> void:
	rgen.velocity.y = clamp(rgen.velocity.y + rgen.gravity * _delta, -800.0, 0)

func generate() -> void:
	if is_just_entered:
		first_phase(0, 0)
		is_just_entered = false
		return
	last_x = second_phase(last_x, 0)

func first_phase(x : int, y : int) -> void:
	if (y >= max_y):
		return
	
	randomize()
	var l_eraser := add_element(x, y, rgen.elements[0]["element"]) #left eraser
	add_element((max_x - x), y, rgen.elements[0]["element"]) #right eraser
	if(y == 0):
		l_eraser.trigger_pos = 0
		l_eraser.connect("next_triggered", rgen, "generate")
	
	var rand : float = randf()
	if (rand >= rgen.elements[0]["probability"]):
		var bonus : PackedScene = rgen.get_wrandom_element(
			rand - rgen.elements[0]["probability"], 1)
		add_element(max_x/2, y, bonus)
	
	if (x < 128):
		x += 32
	y += 256
	first_phase(x, y)

func second_phase(x : int, y :int) -> int:
	if (y >= max_y):
		return x
	
	randomize()
	var l_eraser : = add_element(x, y, rgen.elements[0]["element"]) #left eraser
	add_element((x + 464), y, rgen.elements[0]["element"]) #right eraser
	if(y == 0):
		l_eraser.trigger_pos = 0
		l_eraser.connect("next_triggered", rgen, "generate")
	
	var rand : float = randf()
	if (rand >= rgen.elements[0]["probability"]):
		var bonus : PackedScene = rgen.get_wrandom_element(
			rand - rgen.elements[0]["probability"], 1)
		add_element((x + 232), y, bonus)
	
	if x > 384:
		direction = -1
	elif x < -128:
		direction = 1
	x += 16 * direction
	y += 256
	return second_phase(x, y)
