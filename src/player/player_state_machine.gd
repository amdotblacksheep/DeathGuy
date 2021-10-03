extends StateMachine


func _ready() -> void:
	yield(owner, "ready")
