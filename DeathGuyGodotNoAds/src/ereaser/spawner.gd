extends Node2D


onready var level := get_node("/root/Level")
onready var timer := $StartTimer

export var object : Array = [PackedScene, PackedScene]
export var obj_gravity := -9.8
export var max_pos := 0
export var min_pos := 0

var obj_velocity := Vector2.ZERO
var speed := 8.0
var velocity := Vector2.ZERO
var direction := 1


func _ready() -> void:
	yield(owner, "ready")
	randomize()
	global_position.x = max_pos - (randi() % 140 + 1)
	direction = randi() % 2
	if direction == 0:
		direction = -1


func _physics_process(delta: float) -> void:
	obj_velocity.y = clamp(obj_velocity.y + obj_gravity * delta, -980.0, 0)
	if global_position.x > max_pos or global_position.x < min_pos:
		direction *= -1
		velocity.x *= direction
	velocity.x = speed * direction
	translate(velocity)

func spawn_object() -> void:
	var type := randi() % 20
	if type != 0:
		type = 0
	else:
		type = 1
	var new_object : Node = object[type].instance()
	new_object.set_global_position(global_position)
	new_object.velocity = obj_velocity
	add_child(new_object, true)
	new_object.set_as_toplevel(true)
	level.score = 1

func _on_ObjectExit() -> void:
	spawn_object()

func _on_StartTimer_timeout() -> void:
	spawn_object()
	timer.queue_free()
