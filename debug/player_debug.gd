extends Control
#
#onready var player := get_node("/root/Level/Player")
#onready var direction := $Data/Value/Direction
#onready var rotation := $Data/Value/Rotation
#onready var velocity := $Data/Value/Velocity
#onready var state := $Data/Value/State
#onready var fps := $Data/Value/FPS
#onready var os := $Data/Value/OS
#
#func _ready() -> void:
#	yield(owner, "ready")
#
#
#func _physics_process(_delta: float) -> void:
#	direction.set_text(str(player.direction).pad_decimals(2))
#	rotation.set_text(str(player.rotation).pad_decimals(2))
#	velocity.set_text("( %.2f , %.2f )" % [(player.linear_velocity.x), (player.linear_velocity.y)])
#	state.text = player.state_machine.state.name
#	fps.text = str(Engine.get_frames_per_second())
#	os.text = Main.os
