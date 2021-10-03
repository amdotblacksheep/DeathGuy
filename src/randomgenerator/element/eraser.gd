extends Element


var bonus_score := 10
var adj := 0


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	adj = int( -(velocity.y - 20.0) / 100.0 )

func _on_Detector_body_entered(body: Node) -> void:
	if not body is Player:
		return
	
	if body.is_shielded:
		body.anim_tree["parameters/playback"].travel("fall")
		body.shield_timer.start()
		body.shield_sfx.play()
		return
	
	if body.is_respawning or body.is_despawning:
		return
	
	body.state_machine.transition_to("Despawn")
