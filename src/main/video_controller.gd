extends Node
#Code for Godot Showreel 2021 video 

#onready var player := get_node("/root/Level/Player")
#onready var background := get_node("/root/Level/ParallaxBackground")

#var p_number := 0
#var c_number := 0
#var b_number := 0
#
#var new_color := 0

#0.545


#func _on_Timer_timeout() -> void:
#	p_number = min(p_number + 1, 13)
#	if p_number == 13:
#		p_number = 0
#	player.head.set_texture(load(Data.head_dir + '/' + Data.head[p_number]))

#func _on_Timer_timeout() -> void:
#	c_number = min(c_number + 1, 8)
#	if c_number == 8:
#		c_number = 0
#	player.sprites.set_modulate(Color(Data.color[c_number]))
#	player.sprites.get_material().set_shader_param(
#	"color", Data.shader_color[c_number])
#	player.particles.set_color(Data.shader_color[c_number])

#func _on_Timer_timeout() -> void:
#	b_number = min(b_number + 1, 4)
#	if b_number == 4:
#		b_number = 0
#	background.background.set_texture(
#	load(Data.back_dir + '/' + Data.background[b_number]))

#func _on_Timer_timeout() -> void:#player head
#	get_parent()._on_RightButton_pressed()

#func _on_Timer_timeout() -> void:#color
#	new_color = min(new_color + 1, 8)
#	if new_color == 8:
#		new_color = 0
#	get_parent()._on_Change_pressed(new_color)

#func _on_Timer_timeout() -> void:#background
#	get_parent()._on_RightButton_pressed()


