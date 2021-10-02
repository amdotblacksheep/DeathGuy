tool
extends Button
class_name ColorSwitch

onready var color_rect := $ColorRect

export var color := Color.white setget set_color
export var locked := true

func _ready() -> void:
	self.color = color

func set_color(value : Color) -> void:
	color = value
	if not color_rect:
		return
	color_rect.color = value
