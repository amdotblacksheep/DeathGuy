extends Control

onready var anim_play := $AnimationPlayer

func _on_SetPause(paused : bool) -> void:
	if paused:
		anim_play.play("set_pause")
	else:
		anim_play.play("RESET")
