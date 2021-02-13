extends State
class_name RGenState

var rgen: Node2D


func _ready() -> void:
	yield(owner, "ready")
	rgen = owner
