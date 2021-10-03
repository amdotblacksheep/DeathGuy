extends RGenState


var element_y := [0, 64, 128]
var max_x := 720


func enter() -> void:
	randomize()

func physics_update(_delta: float) -> void:
	rgen.velocity.y = clamp(rgen.velocity.y + rgen.gravity * _delta, -800.0, 0)

func generate() -> void:
	var x : float = rgen.level.player.get_global_position().x
	var distance : int = sign(rgen.level.player.last_direction) * (96)
	var y := element_y.duplicate(true)
	
	new_generation(x, y, distance)


func new_generation(x : int, y : Array, dist : int) -> void:
	if (y.size() == 0):
		return
	
	randomize()
	var element : PackedScene = rgen.get_wrandom_element(randf(), 0)
	
	var new_element = add_element(x, y[0], element)
	if (y[0] == 128):
		new_element.trigger_pos = 320
		new_element.connect("next_triggered", rgen, "generate")
	
	y.remove(0)
	
	x = check_off_screen(x, dist, max_x)
	new_generation(x, y, dist)
