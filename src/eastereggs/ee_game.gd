extends Node2D

signal hidden_activeted()
signal dialog_triggered(string)

export var fallguy : PackedScene

var initialize_y := -640
var max_x := 720
var strings : Array = ["You like being a bully, huh?", "Do it now if you dare hahaha..."]
var count = 0


func _on_SpawnTimer_timeout() -> void:
	var x := randi() % max_x + 1
	var y := initialize_y
	
	var new_istance : Node = fallguy.instance()
	new_istance.set_position(Vector2(x, y))
	if count >= 7:
		new_istance.set_pickable(false)
	add_child(new_istance, true)
	
	connect("hidden_activeted", new_istance, "_on_EEGame_hidden_activeted")
	new_istance.connect("erased", self, "_on_FallGuy_erased")

func _on_FallGuy_erased() -> void:
	count += 1
	if count == 1:
		emit_signal("dialog_triggered", strings[0])
	elif count == 7:
		emit_signal("dialog_triggered", strings[1])
		emit_signal("hidden_activeted")
