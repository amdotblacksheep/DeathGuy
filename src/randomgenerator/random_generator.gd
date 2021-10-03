extends Node2D

signal state_changed()

onready var level := get_node("/root/Level")
onready var state_machine := $StateMachine
onready var timer := $State

export var elements : Array = [
	{#eraser
		"probability" : 0.85,
		"element" : preload("res://src/randomgenerator/element/Eraser.tscn")
	},
	{#coin
		"probability" : 0.1,
		"element" : preload("res://src/randomgenerator/element/Coin.tscn")
	},
	{#shield
		"probability" : 0.03,
		"element" : preload("res://src/randomgenerator/element/Shield.tscn")
	},
	{#star
		"probability" : 0.02,
		"element" : preload("res://src/randomgenerator/element/Star.tscn")
	}
]

export var gravity := -8.0

var velocity := Vector2.ZERO

var state_map := ["Standard", "Tunnel", "Sniper", "Burst"]
var current_state := "Standard"
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
	next_state = state_map[randi() % state_map.size()]
	state_map.append(current_state)
	current_state = next_state
	state_map.sort()

func set_StateTimer() -> void:
	var wait_time := rand_range(12.0, 28.0)
	timer.set_wait_time(wait_time)
	timer.start()

func get_wrandom_element(prob : float, element : int) -> PackedScene:
	if prob < elements[element]["probability"]:
		return elements[element]["element"]
	prob -= elements[element]["probability"]
	element += 1
	return get_wrandom_element(prob, element)

func _on_State_timeout() -> void:
	state_machine.transition_to(next_state)
	emit_signal("state_changed")
	set_StateTimer()
	set_NextState()
