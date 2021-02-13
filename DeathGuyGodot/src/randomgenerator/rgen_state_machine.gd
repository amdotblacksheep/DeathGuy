extends StateMachine


func _ready() -> void:
	yield(owner, "ready")
	states_map = {
		"standard" : $StandardGen,
		"burst" :$BurstGen,
		"sniper" : $SniperGen,
		"tunnel" : $TunnelGen
	}
	self.state = $StandardGen
