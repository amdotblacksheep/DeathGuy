extends Node
class_name State


signal change_state(state_path)


func _ready() -> void:
	yield(owner, "ready")

func unhandled_input(_event: InputEvent) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func enter() -> void:
	pass
