extends Control

onready var anim_play := $AnimationPlayer

func _ready() -> void:
	yield(anim_play, "animation_finished")
	get_tree().change_scene_to(Main.main_screen)
