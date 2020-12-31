extends Node
class_name StateMachine


onready var state := get_child(0) setget set_state
var states_map : Dictionary

func _ready() -> void:
	yield(owner, "ready")
	for child in get_children():
		child.connect("change_state", self, "_change_state")

func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


func _physics_process(delta: float) -> void:
	state.physics_process(delta)

func _change_state(new_state_name : String) -> void:
	var new_state : Node = states_map[new_state_name]
	self.state = new_state

func set_state(value : State) -> void:
	state = value
	state.enter()
