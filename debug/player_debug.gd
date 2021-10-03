extends Control

#onready var player := get_node("/root/Level/Player")
#onready var rgen := get_node("/root/Level/RandomGenerator")
#onready var direction := $Data/Value/Direction
#onready var rotation := $Data/Value/Rotation
#onready var velocity := $Data/Value/Velocity
#onready var state := $Data/Value/State
#onready var fps := $Data/Value/FPS
#onready var os := $Data/Value/OS
#onready var pvel := $Data/Value/PVel
#
#func _ready() -> void:
#	yield(owner, "ready")
#
#
#func _physics_process(_delta: float) -> void:
#	direction.set_text(str(player.direction).pad_decimals(2))
#	rotation.set_text(str(player.rotation).pad_decimals(2))
#	velocity.set_text("( %.2f , %.2f )" % [(player.linear_velocity.x), (player.linear_velocity.y)])
#	state.set_text(player.state_machine.state.name)
#	fps.set_text(str(Engine.get_frames_per_second()))
#	os.set_text(Main.os)
#	pvel.set_text(str(rgen.velocity.y).pad_decimals(2))
