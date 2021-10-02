extends StateMachine


func _ready() -> void:
	yield(owner, "ready")
	states_map = {
		"fall" : $Fall,
		"despawn" : $Despawn,
		"respawn" : $Respawn
	}
	self.state = $Respawn
