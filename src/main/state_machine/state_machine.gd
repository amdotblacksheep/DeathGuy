#Based on FINITE STATE MACHINE by GDQuest
#https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/

extends Node
class_name StateMachine

signal transitioned(state_name)

export var initial_state := NodePath()

onready var state: State = get_node(initial_state)

func _ready() -> void:
	yield(owner, "ready")
	
	for child in get_children():
		child.state_machine = self
	
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func transition_to(target_state_name: String) -> void:
	if not has_node(target_state_name):
		return
	
	state.exit()
	state = get_node(target_state_name)
	state.enter()
	emit_signal("transitioned", state.name)
