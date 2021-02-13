extends Node2D


onready var level := get_node("/root/Level")
onready var timer := $StateTimer
onready var state_machine := $StateMachine

export var object : Array = [PackedScene, PackedScene]
export var obj_gravity := -9.8

var obj_velocity := Vector2.ZERO
var state_map := ["standard", "tunnel", "sniper", "burst"]
var current_state := "standard"
var next_state : String


func _ready() -> void:
	yield(owner, "ready")
	state_map.sort()
	set_NextState()

func generate() -> void:
	state_machine.state.generate()

func set_NextState() -> void:
	randomize()
	state_map.remove(state_map.bsearch(current_state))
	state_map.resize(3)
	next_state = state_map[randi() % 3]
	state_map.append(current_state)
	current_state = next_state
	state_map.sort()

func set_StateTimer() -> void:
	var wait_time := rand_range(15.0, 25.0)
	timer.set_wait_time(wait_time)
	timer.start()

func _on_StateTimer_timeout() -> void:
	state_machine.state.emit_signal("change_state", next_state)
	set_StateTimer()
	set_NextState()
