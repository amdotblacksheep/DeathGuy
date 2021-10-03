extends RGenState


func enter() -> void:
	randomize()

func physics_update(_delta: float) -> void:
	rgen.velocity.y = clamp(rgen.velocity.y + rgen.gravity * _delta, -800.0, 0)

func generate() -> void:
	randomize()
	var x : float = rgen.level.player.get_global_position().x
	
	var element : PackedScene = rgen.get_wrandom_element(randf(), 0)
	
	var new_element := add_element(x, 0, element)
	new_element.trigger_pos = 640
	new_element.connect("next_triggered", rgen, "generate")
