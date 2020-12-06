extends State
class_name PlayerState


var player: KinematicBody2D


func _ready() -> void:
	yield(owner, "ready")
	player = owner
